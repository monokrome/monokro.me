IMAGE:=monokrome/monokro.me:latest
GOARGS:=-e DEBUG=1 -it --rm -p 3000:3000 -v "$(call PWD)/go/src/app"


all: image


image:
	docker build -t $(IMAGE) .


server: image
	docker run $(GOARGS) $(IMAGE)


shell: image
	docker run $(GOARGS) $(IMAGE) sh


.PHONY: all image server shell
