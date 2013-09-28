BIN_PATH=./node_modules/.bin/
PUBLIC_PATH=./public/
BUILD_PATH=./build/
MINIFIER=${BIN_PATH}uglifyjs


TARGETS=${PUBLIC_PATH}scripts/main.js \
				${PUBLIC_PATH}feed.xml \
				${PUBLIC_PATH}index.html \
				${PUBLIC_PATH}stylesheets/bootstrap.css \
				${PUBLIC_PATH}stylesheets/entypo.css \
				${PUBLIC_PATH}stylesheets/main.css


MKDIR=mkdir -p


all: ${TARGETS}


${PUBLIC_PATH}%.js: ${BUILD_PATH}%.js
	${MKDIR} $(@D)
	${MINIFIER} $< -o $@


${PUBLIC_PATH}%: ${BUILD_PATH}%
	${MKDIR} $(@D)
	cp $< $@


${BUILD_PATH}%:
	npm install
	${BIN_PATH}wintersmith build --quiet


clean:
	rm -rf "${BUILD_PATH}" "${PUBLIC_PATH}"


.PHONY: all clean
