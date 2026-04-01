package com.example.bookapi;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api")
public class BookController {

    private final List<Book> books = new ArrayList<>();
    private final AtomicLong counter = new AtomicLong();

    public BookController() {
        books.add(new Book(counter.incrementAndGet(), "The Pragmatic Programmer", "David Thomas", "978-0135957059", 2019));
        books.add(new Book(counter.incrementAndGet(), "Clean Code", "Robert C. Martin", "978-0132350884", 2008));
        books.add(new Book(counter.incrementAndGet(), "Docker Deep Dive", "Nigel Poulton", "978-1916585300", 2023));
    }

    @GetMapping("/")
    public ResponseEntity<Map<String, String>> index() {
        return ResponseEntity.ok(Map.of("message", "Welcome to Book API", "version", "1.0.0"));
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        return ResponseEntity.ok(Map.of("status", "healthy"));
    }

    @GetMapping("/books")
    public ResponseEntity<Map<String, Object>> getAllBooks() {
        return ResponseEntity.ok(Map.of("books", books, "count", books.size()));
    }

    @GetMapping("/books/{id}")
    public ResponseEntity<?> getBook(@PathVariable Long id) {
        return books.stream()
                .filter(b -> b.getId().equals(id))
                .findFirst()
                .<ResponseEntity<?>>map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "Book not found")));
    }

    @PostMapping("/books")
    public ResponseEntity<?> createBook(@RequestBody Book book) {
        if (book.getTitle() == null || book.getTitle().isBlank()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Title is required"));
        }
        book.setId(counter.incrementAndGet());
        books.add(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(book);
    }

    @DeleteMapping("/books/{id}")
    public ResponseEntity<?> deleteBook(@PathVariable Long id) {
        boolean removed = books.removeIf(b -> b.getId().equals(id));
        if (!removed) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "Book not found"));
        }
        return ResponseEntity.ok(Map.of("message", "Book deleted successfully"));
    }
}
