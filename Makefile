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


# This has to be done as a separate process in order to prevent the wild card
# from not working, because `wintersmith build` has to have occurred before we
# have expanded $(targets) or else it wont expand to any files which have not
# been created by the build yet. Any better solutions are welcome.
all: $(PUBLIC_PATH)index.html application
	${MAKE} $(targets) 


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
	@${RM} "$(BUILD_PATH)" "$(PUBLIC_PATH)"


.PHONY: all clean application
