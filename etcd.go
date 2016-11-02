package main

import (
	"github.com/coreos/etcd/client"
	"golang.org/x/net/context"
	"log"
	"time"
)

const CERT_KEY = "/letsencrypt"

func etcdClient() (client.Client, error) {
	return client.New(client.Config{
		Endpoints:               []string{"http://127.0.0.1:2379"},
		Transport:               client.DefaultTransport,
		HeaderTimeoutPerRequest: time.Second,
	})
}

func storeCertificateData(data string) error {
	c, err := etcdClient()
	if err != nil {
		return err
	}

	keysAPI := client.NewKeysAPI(c)
	log.Print("Updating certificate data. ")

	_, err = keysAPI.Set(context.Background(), CERT_KEY, data, nil)
	if err != nil {
		log.Println("Failed: ", err)
		return err
	}

	log.Println("DONE.")
	return nil
}

func getCertificateData() (string, error) {
	c, err := etcdClient()
	if err != nil {
		return "", err
	}

	keysAPI := client.NewKeysAPI(c)
	log.Print("Restoring certificate data. ")

	response, err := keysAPI.Get(context.Background(), CERT_KEY, nil)
	if err != nil {
		log.Println("Failed: ", err)
		return "", err
	}

	log.Println("DONE.")
	return response.Node.Value, nil
}
