BIN_PATH := ./node_modules/.bin/
PUBLIC_PATH := ./public/
BUILD_PATH := ./build/
MINIFIER := $(BIN_PATH)uglifyjs


OBJECTS := scripts/main.js \
  				 feed.xml \
  				 index.html \
  				 stylesheets/bootstrap.css \
  				 stylesheets/entypo.css \
  				 stylesheets/main.css \
  				 fonts/entypo.eot \
  				 fonts/entypo.svg \
  				 fonts/entypo.ttf \
  				 fonts/entypo.woff


MKDIR := mkdir -p


target_name = $(PUBLIC_PATH)$(object)
targets := $(foreach object,$(OBJECTS),$(target_name))


all: $(targets)


$(PUBLIC_PATH)%.js: $(BUILD_PATH)%.js
	$(MKDIR) $(@D)
	$(MINIFIER) $< -o $@


$(PUBLIC_PATH)%: $(BUILD_PATH)%
	$(MKDIR) $(@D)
	cp $< $@


$(BUILD_PATH)%:
	npm install
	$(BIN_PATH)wintersmith build --quiet


clean:
	@rm -rf "$(BUILD_PATH)" "$(PUBLIC_PATH)"


.PHONY: all clean
