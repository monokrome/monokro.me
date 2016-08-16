package main

import (
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"strings"
)

const MatchingResourceNotFound = "No resource found matching the given request."

var requestMethods = []string{"DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"}

func serializeToResponse(w *http.ResponseWriter, v interface{}) []byte {
	jsonData, err := json.Marshal(v)

	if err != nil {
		log.Print(err)
	}

	return jsonData
}

type restApiHandlerStore map[string]func(r *http.Request) (interface{}, error)

type restApi struct {
	prefix              string
	itemResources       map[string]restApiHandlerStore
	collectionResources map[string]restApiHandlerStore
}

func NewRestApi(prefix string) *restApi {
	log.Print("Creating new REST API at ", prefix)

	itemResources := make(map[string]restApiHandlerStore)
	collectionResources := make(map[string]restApiHandlerStore)

	for _, method := range requestMethods {
		itemResources[method] = make(restApiHandlerStore)
		collectionResources[method] = make(restApiHandlerStore)
	}

	api := &restApi{
		prefix:              prefix,
		itemResources:       itemResources,
		collectionResources: collectionResources,
	}

	http.HandleFunc(api.prefix, api.onRequestReceived)

	return api
}

// Interface for getting the base path to a RESTful resource
type resource interface {
	BaseName() string
}

// Interface for resources which are able to work with individual entities
type deleteItemResource interface {
	DeleteItem(r *http.Request) (interface{}, error)
}
type getItemResource interface {
	GetItem(r *http.Request) (interface{}, error)
}
type headItemResource interface {
	HeadItem(r *http.Request) (interface{}, error)
}
type optionsItemResource interface {
	OptionsItem(r *http.Request) (interface{}, error)
}
type patchItemResource interface {
	PatchItem(r *http.Request) (interface{}, error)
}
type postItemResource interface {
	PostItem(r *http.Request) (interface{}, error)
}
type putItemResource interface {
	PutItem(r *http.Request) (interface{}, error)
}

// Interface for resources which are able to work with collections of entities
type deleteCollectionResource interface {
	DeleteCollection(r *http.Request) (interface{}, error)
}
type getCollectionResource interface {
	GetCollection(r *http.Request) (interface{}, error)
}
type headCollectionResource interface {
	HeadCollection(r *http.Request) (interface{}, error)
}
type optionsCollectionResource interface {
	OptionsCollection(r *http.Request) (interface{}, error)
}
type patchCollectionResource interface {
	PatchCollection(r *http.Request) (interface{}, error)
}
type postCollectionResource interface {
	PostCollection(r *http.Request) (interface{}, error)
}
type putCollectionResource interface {
	PutCollection(r *http.Request) (interface{}, error)
}

// Allows registering of resources to specific APIs
func (api *restApi) RegisterResource(iface interface{}) {
	baseName := strings.ToLower(iface.(resource).BaseName())

	if handler, ok := iface.(deleteItemResource); ok {
		api.itemResources["DELETE"][baseName] = handler.DeleteItem
	}

	if handler, ok := iface.(getItemResource); ok {
		api.itemResources["GET"][baseName] = handler.GetItem
	}

	if handler, ok := iface.(headItemResource); ok {
		api.itemResources["HEAD"][baseName] = handler.HeadItem
	}

	if handler, ok := iface.(patchItemResource); ok {
		api.itemResources["PATCH"][baseName] = handler.PatchItem
	}

	if handler, ok := iface.(postItemResource); ok {
		api.itemResources["POST"][baseName] = handler.PostItem
	}

	if handler, ok := iface.(putItemResource); ok {
		api.itemResources["PUT"][baseName] = handler.PutItem
	}

	if handler, ok := iface.(deleteCollectionResource); ok {
		api.collectionResources["DELETE"][baseName] = handler.DeleteCollection
	}

	if handler, ok := iface.(getCollectionResource); ok {
		api.collectionResources["GET"][baseName] = handler.GetCollection
	}

	if handler, ok := iface.(headCollectionResource); ok {
		api.collectionResources["HEAD"][baseName] = handler.HeadCollection
	}

	if handler, ok := iface.(patchCollectionResource); ok {
		api.collectionResources["PATCH"][baseName] = handler.PatchCollection
	}

	if handler, ok := iface.(postCollectionResource); ok {
		api.collectionResources["POST"][baseName] = handler.PostCollection
	}

	if handler, ok := iface.(putCollectionResource); ok {
		api.collectionResources["PUT"][baseName] = handler.PutCollection
	}
}

func (api *restApi) handleItem(baseName string, r *http.Request) (interface{}, error) {
	if resources, ok := api.itemResources[r.Method]; ok {
		if handler, ok := resources[baseName]; ok {
			response, err := handler(r)
			return response, err
		}
	}

	return nil, errors.New(MatchingResourceNotFound)
}

func (api *restApi) handleCollection(baseName string, r *http.Request) (interface{}, error) {
	if resources, ok := api.collectionResources[r.Method]; ok {
		if handler, ok := resources[baseName]; ok {
			response, err := handler(r)
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
		response, err = api.handleCollection(parts[0], r)
	} else {
		response, err = api.handleItem(parts[0], r)
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
