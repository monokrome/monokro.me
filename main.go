package main

import (
	"log"
	"net/http"
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
	log.SetPrefix("monokro.me")
	http.HandleFunc("/", onRequestReceived)

	if isDebugMode() {
		ServeDevelopment()
	} else {
		ServeTLS()
	}
}
