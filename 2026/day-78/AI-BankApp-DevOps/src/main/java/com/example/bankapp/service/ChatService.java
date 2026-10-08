package com.example.bankapp.service;

import com.example.bankapp.model.Account;
import com.example.bankapp.model.Transaction;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Service
public class ChatService {

    @Value("${ollama.url}")
    private String ollamaUrl;

    @Value("${ollama.model}")
    private String model;

    private final RestTemplate restTemplate = new RestTemplate();
    private final AccountService accountService;

    public ChatService(AccountService accountService) {
        this.accountService = accountService;
    }

    public String chat(Account account, String userMessage) {
        List<Transaction> recent = accountService.getTransactionHistory(account);
        String context = buildContext(account, recent);

        Map<String, Object> request = Map.of(
            "model", model,
            "messages", List.of(
                Map.of("role", "system", "content", context),
                Map.of("role", "user", "content", userMessage)
            ),
            "stream", false
        );

        try {
            Map<String, Object> response = restTemplate.postForObject(
                ollamaUrl + "/api/chat", request, Map.class
            );
            if (response != null && response.containsKey("message")) {
                Map<String, String> message = (Map<String, String>) response.get("message");
                return message.get("content");
            }
            return "Sorry, I couldn't process that.";
        } catch (Exception e) {
            return "AI assistant is unavailable. Please make sure Ollama is running.";
        }
    }

    private String buildContext(Account account, List<Transaction> transactions) {
        StringBuilder sb = new StringBuilder();
        sb.append("You are a helpful banking assistant for BankApp. ");
        sb.append("Keep answers short and friendly (2-3 sentences max). ");
        sb.append("\n\nCustomer details:");
        sb.append("\n- Username: ").append(account.getUsername());
        sb.append("\n- Balance: $").append(account.getBalance());
        sb.append("\n- Account ID: ").append(account.getId());

        if (!transactions.isEmpty()) {
            sb.append("\n\nRecent transactions:");
            int limit = Math.min(transactions.size(), 5);
            for (int i = 0; i < limit; i++) {
                Transaction t = transactions.get(i);
                sb.append("\n- ").append(t.getType())
                  .append(": $").append(t.getAmount())
                  .append(" on ").append(t.getTimestamp().toLocalDate());
            }
        } else {
            sb.append("\n\nNo transactions yet.");
        }

        return sb.toString();
    }
}
