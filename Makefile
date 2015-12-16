SRC=./src/
DIST=./dist/

SCRIPT_OUT=$(DIST)mk.js
STYLES_OUT=$(DIST)mk.css
MARKUP_OUT=$(DIST)index.html

JS_COMPILER=./node_modules/.bin/babel
CSS_COMPILER=./node_modules/.bin/stylus


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


.PHONY: clean all
