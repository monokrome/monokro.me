all: client server


client: dependencies
	./node_modules/.bin/webpack -p --progress --colors


dependencies:
	npm install


clean:
	rm -rf dist


image:
	docker build -t monokrome/monokro.me .


server:
	postgrest postgres://localhost:5432/mk \
		--port 3100 \
		--schema public \
		--anonymous $(USER) \
		--pool 200


.PYHONY: all clean development dependencies image server
