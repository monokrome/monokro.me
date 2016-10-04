package main

import (
	"github.com/tdewolff/minify"
	"github.com/tdewolff/minify/html"
	"html/template"
	"io/ioutil"
)

var (
	templateCache map[string]*template.Template
	minifier      *minify.M
)

func init() {
	templateCache = make(map[string]*template.Template)
}

func init() {
	minifier = minify.New()
	minifier.AddFunc("text/html", html.Minify)
}

func safeCSSFunc(data string) template.CSS {
	return template.CSS(data)
}

func safeHTMLFunc(data string) template.HTML {
	return template.HTML(data)
}

func loadTemplate(fileName string) (*template.Template, error) {
	tmpl, ok := templateCache[fileName]
	if ok == true {
		return tmpl, nil
	}

	tmpl = template.New(fileName).Funcs(template.FuncMap{
		"css":  safeCSSFunc,
		"html": safeHTMLFunc,
	})

	content, err := ioutil.ReadFile("templates/index.html")
	checkError(err)

	if isDebugMode() != true {
		content, err = minifier.Bytes("text/html", content)
		checkError(err)
	}

	_, err = tmpl.Parse(string(content))
	checkError(err)

	if isDebugMode() != true {
		templateCache[fileName] = tmpl
	}

	return tmpl, nil
}
