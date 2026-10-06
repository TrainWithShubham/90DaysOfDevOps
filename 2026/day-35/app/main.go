package main

import (
	"fmt"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World! Running from an optimized container!")
}

func main() {
	http.HandleFunc("/", helloHandler)
	fmt.Println("Server starting on port 8080...")
	http.ListenAndServe(":8080", nil)
}
