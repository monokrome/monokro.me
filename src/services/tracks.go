package main

import (
	"net/http"
	"time"
)

type Track struct {
	Identifier string
	Title      string
	Length     time.Duration
}

type TracksResource struct{}

func getMockTrack() Track {
	return Track{Identifier: "Test", Title: "Hey", Length: time.Second * 30}
}

func (resource TracksResource) GetCollection(r *http.Request) (interface{}, error) {
	return []Track{getMockTrack(), getMockTrack(), getMockTrack()}, nil
}

func (resource TracksResource) GetItem(r *http.Request) (interface{}, error) {
	return getMockTrack(), nil
}
