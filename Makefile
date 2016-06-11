all: dependencies
	./node_modules/.bin/webpack -p --progress --colors


dependencies:
	npm install


clean:
	rm -rf dist


.PYHONY: all development clean dependencies
