all: dependencies
	./node_modules/.bin/webpack -p --progress --colors


development: dependencies
	./node_modules/.bin/webpack-dev-server --progress --colors --watch --hot --inline --content-base dist


dependencies:
	npm install


clean:
	rm -rf dist


.PYHONY: all development clean dependencies
