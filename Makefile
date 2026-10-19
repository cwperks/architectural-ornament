OPENSCAD ?= openscad
MODELS := acorn-finial urn-finial molding-sampler
BUILD_DIR := build

.PHONY: all preview clean

all: $(addprefix $(BUILD_DIR)/,$(addsuffix .stl,$(MODELS)))

preview: $(addprefix $(BUILD_DIR)/,$(addsuffix .png,$(MODELS)))

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/acorn-finial.stl $(BUILD_DIR)/acorn-finial.png: src/finials/acorn.scad
$(BUILD_DIR)/urn-finial.stl $(BUILD_DIR)/urn-finial.png: src/finials/urn.scad src/profiles/moldings.scad
$(BUILD_DIR)/molding-sampler.stl $(BUILD_DIR)/molding-sampler.png: src/profiles/sampler.scad src/profiles/moldings.scad

$(addprefix $(BUILD_DIR)/,$(addsuffix .stl,$(MODELS))): | $(BUILD_DIR)
	$(OPENSCAD) -o $@ $<

$(addprefix $(BUILD_DIR)/,$(addsuffix .png,$(MODELS))): | $(BUILD_DIR)
	$(OPENSCAD) --autocenter --viewall --imgsize=1200,1200 --projection=ortho --render -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
