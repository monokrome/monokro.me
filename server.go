package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	name := html.EscapeString(r.URL.Path)[1:]

	if name == "" {
		name = "World"
	}

	fmt.Fprintf(w, "Hello, %q", name)
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Starting server on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
