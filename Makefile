SRC=./src/
DIST=./dist/

SCRIPT_OUT=$(DIST)mk.js
STYLES_OUT=$(DIST)mk.css
MARKUP_OUT=$(DIST)index.html

NPM_BIN=./node_modules/.bin/
JS_COMPILER=$(NPM_BIN)babel
CSS_COMPILER=$(NPM_BIN)stylus

SERVER=$(NPM_BIN)browser-sync


all: $(MARKUP_OUT) $(SCRIPT_OUT) $(STYLES_OUT)


$(DIST)%.html: $(SRC)%.html $(DIST)
	cp $< $@


$(DIST)%.js: $(SRC)%.js $(DIST)
	$(JS_COMPILER) $< > $@


$(DIST)%.css: $(SRC)%.styl $(DIST)
	 $(CSS_COMPILER) $< -o $(@D)


$(DIST):
	mkdir $@


clean:
	rm -r $(DIST)


server:
	$(SERVER) start \
		--server "$(DIST)" \
		--startPath index.html \
		--directory \
		--files "$(DIST)/*.html,$(DIST)/*.js,$(DIST)/*.css"


.PHONY: clean all
