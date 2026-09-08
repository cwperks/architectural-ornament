OPENSCAD ?= openscad
MODEL := src/finials/acorn.scad
BUILD_DIR := build

.PHONY: all preview clean

all: $(BUILD_DIR)/acorn-finial.stl

preview: $(BUILD_DIR)/acorn-finial.png

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/acorn-finial.stl: $(MODEL) | $(BUILD_DIR)
	$(OPENSCAD) -o $@ $<

$(BUILD_DIR)/acorn-finial.png: $(MODEL) | $(BUILD_DIR)
	$(OPENSCAD) --autocenter --viewall --imgsize=1200,1200 --projection=ortho --render -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
