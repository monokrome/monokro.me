package main

import (
	"log"
	"net/http"
	"os"
)

func safeCheckError(err error) {
	if err != nil {
		log.Println(err)
	}
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	port := os.Getenv("PORT")

	if port == "" {
		port = "7000"
	}

	listenAddress := ":" + port

	log.SetPrefix("monokro.me")
	log.Println("Started server at ", listenAddress)

	http.HandleFunc("/", onRequestReceived)
	http.ListenAndServe(listenAddress, nil)
}
