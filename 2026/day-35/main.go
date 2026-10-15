package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello Day 35! This is a heavy single-stage build.")
    })
    fmt.Println("Server starting on port 8080...")
    http.ListenAndServe(":8080", nil)
}
