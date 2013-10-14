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
CP := cp -R
RM := rm -rf


source_name = $(wildcard $(BUILD_PATH)$(object))
target_name = $(subst $(BUILD_PATH),$(PUBLIC_PATH),$(call source_name,$(object)))
targets := $(foreach object,$(OBJECTS),$(target_name))


all: clean $(PUBLIC_PATH)index.html
	${MAKE} application


application: $(targets)


$(PUBLIC_PATH)%.css: $(BUILD_PATH)%.css
	$(MKDIR) $(@D)
	$(STYLE_COMPRESSOR) $< -o $@


$(PUBLIC_PATH)%.js: $(BUILD_PATH)%.js
	$(MKDIR) $(@D)
	$(SCRIPT_COMPRESSOR) $< -o $@


$(PUBLIC_PATH)%: $(BUILD_PATH)%
	$(MKDIR) $(@D)
	$(CP) $< $@


$(BUILD_PATH)%:
	npm install
	$(BIN_PATH)wintersmith build --quiet


clean:
	${RM} "$(BUILD_PATH)" "$(PUBLIC_PATH)"


.PHONY: all application clean
