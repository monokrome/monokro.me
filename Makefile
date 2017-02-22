PROJECT=monokro.me


latest: build
	docker build -t monokrome/$(PROJECT):$@ .


production: build
	docker build -t monokrome/$(PROJECT):$@ .


test:
	ptw mk


build:
	mkdir build


.PHONY: all test latest production
