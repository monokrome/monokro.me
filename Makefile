DEP_PATH=./node_modules/
DEP_BIN_PATH=$(DEP_PATH).bin/
DIST=./dist/
SRC=./src/


TYPINGS=angular2 es6-promise rx # rx-lite


SYNC_WITH=$(DEP_BIN_PATH)browser-sync start
SYNC_FLAGS=--server '$(DIST)' \
					 --files '$(DIST)*.css, $(DIST)*.html, $(DIST)*.js' \
					 --no-open \
					 --reload-debounce=50 \
					 --no-notify \
					 --index index.html


CSS=$(DEP_BIN_PATH)node-sass
CSSDEPS=./node_modules/normalize.css/normalize.css
CSSFLAGS=--include-path "$(DEP_PATH)"


MARKUP=$(DEP_BIN_PATH)jade
MARKUPFLAGS=


SCRIPTS=$(DEP_BIN_PATH)tsc
SCRIPT_SOURCES=$(wildcard $(SRC)components/*.ts)
SCRIPTSFLAGS=--target ES5 \
						 --module commonjs \
						 --emitDecoratorMetadata \
						 --experimentalDecorators \
						 --suppressImplicitAnyIndexErrors


typing_targets=$(foreach target,$(TYPINGS),typings/$(target))


all: $(DIST)index.html $(DIST)index.css $(DIST)index.js


$(DIST)%.html: $(SRC)%.jade node_modules
	mkdir -p "$(@D)"
	$(MARKUP) $(MARKUPFLAGS) "$<" -o "$(@D)"


$(DIST)%.css: $(SRC)%.scss node_modules
	mkdir -p "$(@D)"
	$(CSS) $(CSSFLAGS) "$<" -o "$(@D)"


$(DIST)%.js: $(SRC)%.ts $(SCRIPT_SOURCES) $(typing_targets)
	mkdir -p "$(@D)"
	$(SCRIPTS) $(SCRIPTSFLAGS) $< --outFile "$@"


typings/%: node_modules
	$(DEP_BIN_PATH)tsd install rx-lite  # Hack for dumb output location.
	$(DEP_BIN_PATH)tsd install $(TYPINGS)


node_modules: package.json
	npm install
	touch $@


clean:
	rm -r $(DIST)
	rm -r typings


develop: all
	$(SYNC_WITH) $(SYNC_FLAGS)


.PHONY: all clean develop
