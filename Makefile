all: dependencies
	./node_modules/.bin/webpack -p --progress --colors


dependencies:
	npm install


clean:
	rm -rf dist


image:
	git archive HEAD > docker.zip
	docker build -t monokrome/monokro.me .


.PYHONY: all development clean dependencies image
