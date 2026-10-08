package com.example.bankapp.service;

import com.example.bankapp.model.Account;
import com.example.bankapp.model.Transaction;
import com.example.bankapp.repository.AccountRepository;
import com.example.bankapp.repository.TransactionRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AccountService implements UserDetailsService {

    private final AccountRepository accountRepository;
    private final TransactionRepository transactionRepository;
    private final PasswordEncoder passwordEncoder;

    public AccountService(AccountRepository accountRepository,
                          TransactionRepository transactionRepository,
                          PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.transactionRepository = transactionRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return accountRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
    }

    public boolean registerAccount(String username, String password) {
        if (accountRepository.findByUsername(username).isPresent()) {
            return false;
        }
        Account account = new Account(username, passwordEncoder.encode(password));
        accountRepository.save(account);
        return true;
    }

    @Transactional
    public void deposit(Account account, BigDecimal amount) {
        account.setBalance(account.getBalance().add(amount));
        accountRepository.save(account);

        Transaction transaction = new Transaction(amount, "Deposit", LocalDateTime.now(), account);
        transactionRepository.save(transaction);
    }

    @Transactional
    public boolean withdraw(Account account, BigDecimal amount) {
        if (account.getBalance().compareTo(amount) < 0) {
            return false;
        }
        account.setBalance(account.getBalance().subtract(amount));
        accountRepository.save(account);

        Transaction transaction = new Transaction(amount, "Withdrawal", LocalDateTime.now(), account);
        transactionRepository.save(transaction);
        return true;
    }

    @Transactional
    public String transferAmount(Account from, String toUsername, BigDecimal amount) {
        if (from.getUsername().equals(toUsername)) {
            return "Cannot transfer to yourself.";
        }
        if (from.getBalance().compareTo(amount) < 0) {
            return "Insufficient funds.";
        }
        Account to = accountRepository.findByUsername(toUsername).orElse(null);
        if (to == null) {
            return "Recipient not found.";
        }

        from.setBalance(from.getBalance().subtract(amount));
        to.setBalance(to.getBalance().add(amount));
        accountRepository.save(from);
        accountRepository.save(to);

        LocalDateTime now = LocalDateTime.now();
        transactionRepository.save(new Transaction(amount, "Transfer Out", now, from));
        transactionRepository.save(new Transaction(amount, "Transfer In", now, to));

        return null; // null means success
    }

    public List<Transaction> getTransactionHistory(Account account) {
        return transactionRepository.findByAccountIdOrderByTimestampDesc(account.getId());
    }
}
