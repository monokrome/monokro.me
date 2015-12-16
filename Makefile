SRC=./src/
DIST=./dist/

SCRIPT_OUT=$(DIST)mk.js
STYLES_OUT=$(DIST)mk.css
MARKUP_OUT=$(DIST)index.html

NPM_DEPS=./node_modules/
NPM_BIN=$(NPM_DEPS).bin/

JS_COMPILER=$(NPM_BIN)babel
CSS_COMPILER=$(NPM_BIN)stylus

SERVER=$(NPM_BIN)browser-sync
VENDOR_SOURCES=$(NPM_DEPS)three.js/build/three.min.js


all: $(MARKUP_OUT) $(SCRIPT_OUT) $(STYLES_OUT)


$(DIST)%.html: $(SRC)%.html $(DIST)
	cp $< $@


$(DIST)%.css: $(SRC)%.styl $(DIST)
	 $(CSS_COMPILER) $< -o $(@D)


$(DIST)vendor.js: $(VENDOR_SOURCES) $(DIST)
	cat $(VENDOR_SOURCES) > $@


$(DIST)%.js: $(SRC)%.js $(DIST)vendor.js .babelrc $(DIST)
	$(JS_COMPILER) $< > $@


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
