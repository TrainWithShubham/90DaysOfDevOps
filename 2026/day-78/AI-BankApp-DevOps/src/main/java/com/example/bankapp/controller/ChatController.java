package com.example.bankapp.controller;

import com.example.bankapp.model.Account;
import com.example.bankapp.service.ChatService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class ChatController {

    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    @PostMapping("/chat")
    public Map<String, String> chat(@AuthenticationPrincipal Account account,
                                    @RequestBody Map<String, String> request) {
        String message = request.getOrDefault("message", "");
        String reply = chatService.chat(account, message);
        return Map.of("reply", reply);
    }
}
