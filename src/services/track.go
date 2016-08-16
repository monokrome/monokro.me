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

func (track *Track) GetURL() string {
	return "https://www.google.com/" + track.Identifier
}

type TrackResource struct{}

func getMockTrack() Track {
	return Track{
		Identifier: "Test",
		Title:      "Hey",
		Length:     time.Second * 30,
	}
}

func (resource TrackResource) BaseName() string {
	return "tracks"
}

func (resource TrackResource) GetCollection(r *http.Request) (interface{}, error) {
	return []Track{getMockTrack(), getMockTrack(), getMockTrack()}, nil
}

func (resource TrackResource) GetItem(r *http.Request) (interface{}, error) {
	return getMockTrack(), nil
}
