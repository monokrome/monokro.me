PROJECT_NAME=monokro.me


latest: build
	docker build -t monokrome/$(PROJECT_NAME):$@ .


production: build
	docker build -t monokrome/$(PROJECT_NAME):$@ .


test:
	ptw mk


build:
	mkdir build


.PHONY: all test latest production
