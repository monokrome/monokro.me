package main

import (
	"net/http"
)

type ResponseContext struct {
	Timeline   []twitterTimelineResponse
	Stylesheet string
}

func onRequestReceived(response http.ResponseWriter, request *http.Request) {
	var context ResponseContext

	tmpl, err := loadTemplate("templates/index.html")
	checkError(err)

	context.Stylesheet = getStyles()
	context.Timeline, err = getTwitterTimeline("monokrome")
	safeCheckError(err)

	err = tmpl.Execute(response, context)
	checkError(err)
}
