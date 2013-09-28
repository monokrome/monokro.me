BIN_PATH := ./node_modules/.bin/
PUBLIC_PATH := ./public/
BUILD_PATH := ./build/

SCRIPT_COMPRESSOR := $(BIN_PATH)uglifyjs
STYLE_COMPRESSOR := $(BIN_PATH)sqwish


OBJECTS := scripts/main.js \
           articles/* \
           feed.xml \
           index.html \
           stylesheets/* \
           fonts/* \
           images/*


MKDIR := mkdir -p

source_name = $(wildcard $(BUILD_PATH)$(object))
target_name = $(subst $(BUILD_PATH),$(PUBLIC_PATH),$(call source_name,$(object)))
targets := $(foreach object,$(OBJECTS),$(target_name))


# One file must be manually depended in order to trigger the initial build
# process. This comes with weird issue which can occur, regardless. We can't
# run the `wildcard` function on a specific path if the path has not been built
# yet, so it is possible that some files expected to be found by the wildcard
# will not be built unless 'index.html' changes.
#
# I'd like to find a way around this, but don't want to spend too much time on
# the problem. This works for now.
all: $(PUBLIC_PATH)index.html $(targets)


$(PUBLIC_PATH)%.css: $(BUILD_PATH)%.css
	$(MKDIR) $(@D)
	$(STYLE_COMPRESSOR) $< -o $@


$(PUBLIC_PATH)%.js: $(BUILD_PATH)%.js
	$(MKDIR) $(@D)
	$(SCRIPT_COMPRESSOR) $< -o $@


$(PUBLIC_PATH)%: $(BUILD_PATH)%
	$(MKDIR) $(@D)
	cp -R $< $@


$(BUILD_PATH)%:
	npm install
	$(BIN_PATH)wintersmith build --quiet


clean:
	@rm -rf "$(BUILD_PATH)" "$(PUBLIC_PATH)"


.PHONY: all clean build
