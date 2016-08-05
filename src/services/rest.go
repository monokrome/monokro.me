package main

import (
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"strings"
)

const MatchingResourceNotFound = "No resource found matching the given request."

func serializeToResponse(w *http.ResponseWriter, v interface{}) []byte {
	jsonData, err := json.Marshal(v)

	if err != nil {
		log.Print(err)
	}

	return jsonData
}

// Simple wrapper for handling RESTful requests
// TODO: Should this be an http.Handler or something? It feels hacky right now.
type restApi struct {
	prefix string

	// Item resources
	deleteItemResources  map[string]deleteItemResource
	getItemResources     map[string]getItemResource
	headItemResources    map[string]headItemResource
	optionsItemResources map[string]optionsItemResource
	patchItemResources   map[string]patchItemResource
	postItemResources    map[string]postItemResource
	putItemResources     map[string]putItemResource

	// Collection resources
	deleteCollectionResources  map[string]deleteCollectionResource
	getCollectionResources     map[string]getCollectionResource
	headCollectionResources    map[string]headCollectionResource
	optionsCollectionResources map[string]optionsCollectionResource
	patchCollectionResources   map[string]patchCollectionResource
	postCollectionResources    map[string]postCollectionResource
	putCollectionResources     map[string]putCollectionResource
}

func NewRestApi(prefix string) *restApi {
	log.Print("Creating new REST API at ", prefix)

	api := &restApi{
		prefix:                    prefix,
		getCollectionResources:    make(map[string]getCollectionResource),
		getItemResources:          make(map[string]getItemResource),
		deleteCollectionResources: make(map[string]deleteCollectionResource),
		deleteItemResources:       make(map[string]deleteItemResource),
	}

	http.HandleFunc(api.prefix, api.onRequestReceived)

	return api
}

// Interface for getting the base path to a RESTful resource
type resource interface {
	BaseName() string
}

// Interface for resources which are able to work with individual entities
type getItemResource interface {
	GetItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type deleteItemResource interface {
	DeleteItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type postItemResource interface {
	PostItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type putItemResource interface {
	PutItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type headItemResource interface {
	HeadItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type patchItemResource interface {
	PatchItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type optionsItemResource interface {
	OptionsItem(w http.ResponseWriter, r *http.Request) (interface{}, error)
}

// Interface for resources which are able to work with collections of entities
type getCollectionResource interface {
	GetCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type deleteCollectionResource interface {
	DeleteCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type postCollectionResource interface {
	PostCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type putCollectionResource interface {
	PutCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type headCollectionResource interface {
	HeadCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type patchCollectionResource interface {
	PatchCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}
type optionsCollectionResource interface {
	OptionsCollection(w http.ResponseWriter, r *http.Request) (interface{}, error)
}

// Allows registering of resources to specific APIs
func (api *restApi) RegisterResource(iface interface{}) {
	baseName := strings.ToLower(iface.(resource).BaseName())

	if handler, ok := iface.(getCollectionResource); ok {
		api.getCollectionResources[baseName] = handler
	}

	if handler, ok := iface.(getItemResource); ok {
		api.getItemResources[baseName] = handler
	}

	if handler, ok := iface.(deleteCollectionResource); ok {
		api.deleteCollectionResources[baseName] = handler
	}

	if handler, ok := iface.(deleteItemResource); ok {
		api.deleteItemResources[baseName] = handler
	}
}

func (api *restApi) handleList(baseName string, w http.ResponseWriter, r *http.Request) (interface{}, error) {
	if r.Method == "GET" {
		if handler, ok := api.getCollectionResources[baseName]; ok {
			response, err := handler.GetCollection(w, r)
			return response, err
		}
	}

	if r.Method == "DELETE" {
		if handler, ok := api.deleteCollectionResources[baseName]; ok {
			response, err := handler.DeleteCollection(w, r)
			return response, err
		}
	}

	if r.Method == "POST" {
		if handler, ok := api.postCollectionResources[baseName]; ok {
			response, err := handler.PostCollection(w, r)
			return response, err
		}
	}

	if r.Method == "PUT" {
		if handler, ok := api.putCollectionResources[baseName]; ok {
			response, err := handler.PutCollection(w, r)
			return response, err
		}
	}

	if r.Method == "HEAD" {
		if handler, ok := api.headCollectionResources[baseName]; ok {
			response, err := handler.HeadCollection(w, r)
			return response, err
		}
	}

	if r.Method == "OPTIONS" {
		if handler, ok := api.optionsCollectionResources[baseName]; ok {
			response, err := handler.OptionsCollection(w, r)
			return response, err
		}
	}

	if r.Method == "PATCH" {
		if handler, ok := api.patchCollectionResources[baseName]; ok {
			response, err := handler.PatchCollection(w, r)
			return response, err
		}
	}

	if r.Method == "POST" {
		if handler, ok := api.postCollectionResources[baseName]; ok {
			response, err := handler.PostCollection(w, r)
			return response, err
		}
	}

	return nil, errors.New(MatchingResourceNotFound)
}

func (api *restApi) handleDetail(baseName string, w http.ResponseWriter, r *http.Request) (interface{}, error) {
	if r.Method == "GET" {
		if handler, ok := api.getItemResources[baseName]; ok {
			response, err := handler.GetItem(w, r)
			return response, err
		}
	}

	if r.Method == "DELETE" {
		if handler, ok := api.deleteItemResources[baseName]; ok {
			response, err := handler.DeleteItem(w, r)
			return response, err
		}
	}

	if r.Method == "POST" {
		if handler, ok := api.postItemResources[baseName]; ok {
			response, err := handler.PostItem(w, r)
			return response, err
		}
	}

	if r.Method == "PUT" {
		if handler, ok := api.putItemResources[baseName]; ok {
			response, err := handler.PutItem(w, r)
			return response, err
		}
	}

	if r.Method == "HEAD" {
		if handler, ok := api.headItemResources[baseName]; ok {
			response, err := handler.HeadItem(w, r)
			return response, err
		}
	}

	if r.Method == "OPTIONS" {
		if handler, ok := api.optionsItemResources[baseName]; ok {
			response, err := handler.OptionsItem(w, r)
			return response, err
		}
	}

	if r.Method == "PATCH" {
		if handler, ok := api.patchItemResources[baseName]; ok {
			response, err := handler.PatchItem(w, r)
			return response, err
		}
	}

	if r.Method == "POST" {
		if handler, ok := api.postItemResources[baseName]; ok {
			response, err := handler.PostItem(w, r)
			return response, err
		}
	}

	return nil, errors.New(MatchingResourceNotFound)
}

// Handle routing of requests to their resources
func (api *restApi) onRequestReceived(w http.ResponseWriter, r *http.Request) {
	log.Print("Received ", r.Method, " request at: ", r.RequestURI)

	trunctedString := strings.TrimRight(r.RequestURI[len(api.prefix):], "/")
	parts := strings.Split(trunctedString, "/")

	var response interface{}
	var err error

	if len(parts) == 0 {
		// TODO: Show schema
	} else if len(parts) == 1 {
		response, err = api.handleList(parts[0], w, r)
	} else {
		response, err = api.handleDetail(parts[0], w, r)
	}

	if err != nil {
		log.Print(err)
		return
	}

	output, err := json.Marshal(response)

	if err != nil {
		log.Print(err)
		return
	}

	w.Write(output)
}
