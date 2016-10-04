package main

import (
	"log"
	"net/http"
	"os"
	"rsc.io/letsencrypt"
	"strings"
)

type ResponseContext struct {
	Timeline   []twitterTimelineResponse
	Stylesheet string
}

func ServeTLS() {
	var letsEncryptManager letsencrypt.Manager
	log.Println("Starting service on port 443")
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

func redirectToNakedDomain(response http.ResponseWriter, request *http.Request) {
	scheme := request.URL.Scheme

	if scheme == "" {
		scheme = "http"
	}

	absolute_url := scheme + "://" + request.Host[4:] + request.URL.Path
	http.Redirect(response, request, absolute_url, 301)
}

func renderResponse(response http.ResponseWriter, request *http.Request) {
	var context ResponseContext

	tmpl, err := loadTemplate("templates/index.html")
	checkError(err)

	context.Stylesheet = getStyles()
	context.Timeline, err = getTwitterTimeline("monokrome")
	safeCheckError(err)

	err = tmpl.Execute(response, context)
	checkError(err)
}

func onRequestReceived(response http.ResponseWriter, request *http.Request) {
	if strings.HasPrefix(request.Host, "www.") == true {
		redirectToNakedDomain(response, request)
		return
	}

	renderResponse(response, request)
}
