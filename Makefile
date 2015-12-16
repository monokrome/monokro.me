SRC=./src/
DIST=./dist/

SCRIPT_OUT=$(DIST)mk.js
STYLES_OUT=$(DIST)mk.css
MARKUP_OUT=$(DIST)index.html

JS_COMPILER=./node_modules/.bin/babel
CSS_COMPILER=./node_modules/.bin/stylus


all: $(MARKUP_OUT) $(SCRIPT_OUT) $(STYLES_OUT)


$(DIST)%.html: $(DIST)
	cp $(SRC)$*.html $@


$(DIST)%.js: $(DIST)
	$(JS_COMPILER) $(SRC)$*.js > $@


$(DIST)%.css: $(SRC)%.styl $(DIST)
	 $(CSS_COMPILER) $< -o $(@D)


$(DIST):
	mkdir $@


clean:
	rm -r $(DIST)


.PHONY: clean all
