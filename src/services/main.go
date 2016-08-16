package main

import (
	_ "github.com/lib/pq"
	_ "github.com/mattn/go-sqlite3"
	"github.com/menghan/msgpack"
	"github.com/monokrome/restitude"
	"log"
	"net/http"
	"os"
	"time"
)

const defaultBindAddress = "0.0.0.0:5430"

func init() {
	log.Print("Process started at ", time.Now())
}

func getBindAddress() string {
	bindAddress := os.Getenv("PORT")

	if bindAddress != "" {
		return "0.0.0.0:" + bindAddress
	}

	return defaultBindAddress
}

func msgpackSerializer(v interface{}) ([]byte, error) {
	data, err := msgpack.Marshal(v)
	if err != nil {
		return nil, err
	}
	return data, nil
}

func createServices() {
	api := restitude.NewRestApi("/services/")
	api.Serializers["application/msgpack"] = msgpackSerializer
	api.RegisterResource(TracksResource{})
}

func main() {
	bindAddress := getBindAddress()
	log.Print("Starting server at http://", bindAddress)

	http.Handle("/", http.FileServer(http.Dir("../client")))
	createServices()

	log.Fatalln(http.ListenAndServe(bindAddress, nil))
}
