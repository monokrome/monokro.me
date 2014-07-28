PROJECT=mk


JSC=node_modules/.bin/traceur
JSCFLAGS=--outputLanguage es5 --modules commonjs --experimental

MARKUPC=node_modules/.bin/jade
MARKUPCFLAGS=

STYLEC=node_modules/.bin/stylus
STYCLECFLAGS=--prefix mk-


SOURCE_PATH=src/
DIST_PATH=public/

MARKUP_SOURCES=$(wildcard $(SOURCE_PATH)**.jade)
DIST_MARKUP=$(patsubst $(SOURCE_PATH)%.jade,$(DIST_PATH)%.html,$(MARKUP_SOURCES))

STYLE_SOURCES=$(wildcard $(SOURCE_PATH)**.stylus)
DIST_STYLE=$(patsubst $(SOURCE_PATH)%.stylus,$(DIST_PATH)%.css,$(STYLE_SOURCES))

SCRIPT_SOURCES=$(wildcard $(SOURCE_PATH)**.js)
DIST_SCRIPTS=$(DIST_PATH)$(PROJECT).js


all: $(DIST_STYLE) $(DIST_SCRIPTS) $(DIST_MARKUP)


$(DIST_MARKUP): $(DIST_PATH)%.html: $(SOURCE_PATH)%.jade
	mkdir -p $(@D)
	$(MARKUPC) $(MARKUPCFLAGS) -o $(@D) $(SOURCE_PATH)$*.jade > /dev/null


$(DIST_STYLE): $(DIST_PATH)%.css: $(SOURCE_PATH)%.stylus
	mkdir -p $(@D)
	$(STYLEC) $(STYLECFLAGS) $(SOURCE_PATH)$*.stylus > $@


$(DIST_SCRIPTS): $(SCRIPT_SOURCES)
	mkdir -p $(@D)
	$(JSC) $(JSCFLAGS) --out $(DIST_SCRIPTS) $(SCRIPT_SOURCES)


clean:
	rm -r $(DIST_PATH) 2>/dev/null || true


.PHONY: all

