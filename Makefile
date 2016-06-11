all:
	./node_modules/.bin/webpack -p --progress --colors


development:
	./node_modules/.bin/webpack-dev-server --progress --colors --watch --content-base dist


clean:
	rm -rf dist


.PYHONY: all development clean
