package com.example.bookapi;

public class Book {
    private Long id;
    private String title;
    private String author;
    private String isbn;
    private int year;

    public Book() {}

    public Book(Long id, String title, String author, String isbn, int year) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.year = year;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
}
