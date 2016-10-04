package main

import (
	"log"
	"net/http"
	"os"
	"rsc.io/letsencrypt"
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

func ServeTLS() {
	var letsEncryptManager letsencrypt.Manager

	log.Println("Server starting")
	log.Fatalln(letsEncryptManager.ServeHTTPS())
}

func ServeDevelopment() {
	port := os.Getenv("PORT")

	if port == "" {
		port = "7000"
	}

	log.Println("Development server started at http://localhost:", port)
	log.Fatalln(http.ListenAndServe(":"+port, nil))
}

func main() {
	log.SetPrefix("monokro.me")
	http.HandleFunc("/", onRequestReceived)

	if isDebugMode() {
		ServeDevelopment()
	} else {
		ServeTLS()
	}
}
