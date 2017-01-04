PROJECT_NAME=mk


latest: build
	git archive HEAD > build/docker.zip
	docker build -t monokrome/$(PROJECT_NAME):$@ .


production: build
	git archive $@ > build/docker.zip
	docker build -t monokrome/$(PROJECT_NAME):$@ .


test:
	ptw -- --cov=mk -rssX -q $(PROJECTNAME)


build:
	mkdir build


.PHONY: all test latest production
