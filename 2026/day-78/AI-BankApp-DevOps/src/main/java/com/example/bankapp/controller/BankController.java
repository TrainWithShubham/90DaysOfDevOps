package com.example.bankapp.controller;

import com.example.bankapp.model.Account;
import com.example.bankapp.service.AccountService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller
public class BankController {

    private final AccountService accountService;

    public BankController(AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           Model model) {
        if (accountService.registerAccount(username, password)) {
            return "redirect:/login?registered";
        }
        model.addAttribute("error", true);
        return "register";
    }

    @GetMapping("/dashboard")
    public String dashboard(@AuthenticationPrincipal Account account, Model model) {
        model.addAttribute("account", account);
        return "dashboard";
    }

    @PostMapping("/deposit")
    public String deposit(@AuthenticationPrincipal Account account,
                          @RequestParam BigDecimal amount,
                          RedirectAttributes redirectAttributes) {
        accountService.deposit(account, amount);
        return "redirect:/dashboard";
    }

    @PostMapping("/withdraw")
    public String withdraw(@AuthenticationPrincipal Account account,
                           @RequestParam BigDecimal amount,
                           RedirectAttributes redirectAttributes) {
        if (!accountService.withdraw(account, amount)) {
            redirectAttributes.addFlashAttribute("error", "Insufficient funds.");
        }
        return "redirect:/dashboard";
    }

    @PostMapping("/transfer")
    public String transfer(@AuthenticationPrincipal Account account,
                           @RequestParam String toUsername,
                           @RequestParam BigDecimal amount,
                           RedirectAttributes redirectAttributes) {
        String error = accountService.transferAmount(account, toUsername, amount);
        if (error != null) {
            redirectAttributes.addFlashAttribute("error", error);
        }
        return "redirect:/dashboard";
    }

    @GetMapping("/transactions")
    public String transactions(@AuthenticationPrincipal Account account, Model model) {
        model.addAttribute("transactions", accountService.getTransactionHistory(account));
        return "transactions";
    }
}
