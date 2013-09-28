minifier=node_modules/.bin/uglifyjs
script=build/scripts/main


all: minify


minify: application
	${minifier} ${script}.js -o ${script}.min.js


application:
	npm install
	wintersmith build


clean:
	rm -rf build


.PHONY: minify application clean
