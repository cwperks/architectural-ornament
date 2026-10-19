use <moldings.scad>

sample_width = 18;
sample_length = 65;
relief_height = 8;
base_thickness = 3;
gap = 6;
labels = true;
profiles = ["fillet", "bead", "cove", "ogee"];

assert(sample_width > 0 && sample_length > 0 && relief_height > 0);
assert(base_thickness > 0 && gap > 0);

// Open ends expose the cross sections; the common backing keeps the samples together.
union() {
    cube([len(profiles) * (sample_width + gap) + gap, sample_length + 18, base_thickness]);
    for (i = [0:len(profiles) - 1]) {
        translate([gap + i * (sample_width + gap), sample_length + 12, base_thickness - 0.1])
            rotate([90, 0, 0])
                linear_extrude(height = sample_length)
                    polygon(concat(
                        [[0, -0.1], [sample_width, -0.1]],
                        [for (p = molding_section(profiles[i], sample_width, relief_height))
                            [sample_width - p[0], p[1]]]
                    ));
        if (labels)
            translate([gap + i * (sample_width + gap) + sample_width / 2, 5, base_thickness - 0.1])
                linear_extrude(height = 0.8)
                    text(profiles[i], size = 3, halign = "center", font = "Liberation Sans");
    }
}
