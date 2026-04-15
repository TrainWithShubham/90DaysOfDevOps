package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"
	"sync"
	"time"
)

// Product represents a store product
type Product struct {
	ID        int     `json:"id"`
	Name      string  `json:"name"`
	Price     float64 `json:"price"`
	Category  string  `json:"category"`
	InStock   bool    `json:"in_stock"`
	CreatedAt string  `json:"created_at"`
}

var (
	products = []Product{
		{1, "Mechanical Keyboard", 129.99, "Electronics", true, time.Now().Format(time.RFC3339)},
		{2, "Ergonomic Mouse", 59.99, "Electronics", true, time.Now().Format(time.RFC3339)},
		{3, "Standing Desk", 499.99, "Furniture", false, time.Now().Format(time.RFC3339)},
	}
	mu      sync.RWMutex
	counter = 4
)

func writeJSON(w http.ResponseWriter, status int, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(data)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	writeJSON(w, http.StatusOK, map[string]string{
		"message": "Welcome to Go Product API",
		"version": "1.0.0",
	})
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, http.StatusOK, map[string]string{"status": "healthy"})
}

func productsHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		mu.RLock()
		defer mu.RUnlock()
		writeJSON(w, http.StatusOK, map[string]interface{}{
			"products": products,
			"count":    len(products),
		})

	case http.MethodPost:
		var p Product
		if err := json.NewDecoder(r.Body).Decode(&p); err != nil {
			writeJSON(w, http.StatusBadRequest, map[string]string{"error": "Invalid JSON"})
			return
		}
		if strings.TrimSpace(p.Name) == "" {
			writeJSON(w, http.StatusBadRequest, map[string]string{"error": "Name is required"})
			return
		}
		mu.Lock()
		p.ID = counter
		p.CreatedAt = time.Now().Format(time.RFC3339)
		counter++
		products = append(products, p)
		mu.Unlock()
		writeJSON(w, http.StatusCreated, p)

	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func productByIDHandler(w http.ResponseWriter, r *http.Request) {
	idStr := strings.TrimPrefix(r.URL.Path, "/products/")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		writeJSON(w, http.StatusBadRequest, map[string]string{"error": "Invalid ID"})
		return
	}

	switch r.Method {
	case http.MethodGet:
		mu.RLock()
		defer mu.RUnlock()
		for _, p := range products {
			if p.ID == id {
				writeJSON(w, http.StatusOK, p)
				return
			}
		}
		writeJSON(w, http.StatusNotFound, map[string]string{"error": "Product not found"})

	case http.MethodDelete:
		mu.Lock()
		defer mu.Unlock()
		for i, p := range products {
			if p.ID == id {
				products = append(products[:i], products[i+1:]...)
				writeJSON(w, http.StatusOK, map[string]string{"message": "Product deleted"})
				return
			}
		}
		writeJSON(w, http.StatusNotFound, map[string]string{"error": "Product not found"})

	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", indexHandler)
	mux.HandleFunc("/health", healthHandler)
	mux.HandleFunc("/products", productsHandler)
	mux.HandleFunc("/products/", productByIDHandler)

	port := "8080"
	fmt.Printf("🚀 Go Product API running on http://localhost:%s\n", port)
	log.Fatal(http.ListenAndServe(":"+port, mux))
}
