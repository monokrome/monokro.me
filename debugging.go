package main

import (
	"os"
)

func isDebugMode() bool {
	return os.Getenv("DEBUG") != ""
}
