package main

import (
	"encoding/base64"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/cookiejar"
	"net/url"
	"os"
	"strings"
)

const (
	timelineURL string = "https://api.twitter.com/1.1/statuses/user_timeline.json"
)

var twitterCookies *cookiejar.Jar

type twitterTokenResponse struct {
	TokenType   string `json:"token_type"`
	AccessToken string `json:"access_token"`
}

type twitterTimelineResponse struct {
	CreatedAt           string `json:"created_at"`
	DisplayURL          string `json:"display_url"`
	ExpandedURL         string `json:"expanded_url"`
	Favorited           bool   `json:"favorited"`
	Identifier          int    `json:"id"`
	InReplyToScreenName string `json:"in_reply_to_screen_name"`
	Retweeted           bool   `json:"retweeted"`
	Source              string `json:"source"`
	Text                string `json:"text"`
	Truncated           bool   `json:"truncated"`
}

func init() {
	twitterCookies, _ = cookiejar.New(nil)
}

func getTwitterAccessToken() (*twitterTokenResponse, error) {
	if os.Getenv("TWITTER_ACCESS_TOKEN") == "" {
		log.Println("Warning: TWITTER_ACCESS_TOKEN is not set.")
	}

	token := url.QueryEscape(os.Getenv("TWITTER_ACCESS_TOKEN"))
	secret := url.QueryEscape(os.Getenv("TWITTER_ACCESS_TOKEN_SECRET"))
	encoded := base64.StdEncoding.EncodeToString([]byte(token + ":" + secret))

	reader := strings.NewReader("grant_type=client_credentials")
	oauth_url := "https://api.twitter.com/oauth2/token"

	request, err := http.NewRequest("POST", oauth_url, reader)
	if err != nil {
		return nil, err
	}

	request.Header.Add("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8.")
	request.Header.Add("Authorization", "Basic "+encoded)

	client := &http.Client{
		Jar: twitterCookies,
	}

	response, err := client.Do(request)
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()

	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return nil, err
	}

	var tokenResponse *twitterTokenResponse
	err = json.Unmarshal(body, &tokenResponse)
	if err != nil {
		return nil, err
	}

	return tokenResponse, nil
}

func getTwitterTimeline(screenName string) ([]twitterTimelineResponse, error) {
	token, err := getTwitterAccessToken()
	if err != nil {
		return nil, err
	}

	url := timelineURL + "?screen_name=" + screenName + "&count=3"
	request, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, err
	}

	request.Header.Add("Authorization", "Bearer "+token.AccessToken)

	client := &http.Client{}
	response, err := client.Do(request)
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()

	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return nil, err
	}

	var timeline []twitterTimelineResponse
	if err = json.Unmarshal(body, &timeline); err != nil {
		return nil, err
	}

	return timeline, nil
}
