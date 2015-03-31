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
	fmt.Println("Starting server on port 8080")
	server := http.FileServer(http.Dir("./public"))
	log.Fatal(http.ListenAndServe(":8080", server))
}
