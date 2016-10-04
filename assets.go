package main

import (
	"bytes"
	"github.com/yosssi/gcss"
	"log"
	"os"
)

var stylesheet string = ""

func init() {
	getStyles()
}

func getStyles() string {
	if stylesheet != "" {
		return stylesheet
	}

	asset, err := os.Open("assets/stylesheet.gcss")
	if err != nil {
		log.Fatalln(err)
	}
	defer asset.Close()

	var buffer bytes.Buffer
	if _, err := gcss.Compile(&buffer, asset); err != nil {
		log.Fatalln(err)
	}

	if isDebugMode() {
		return buffer.String()
	}

	stylesheet = buffer.String()
	return stylesheet
}
