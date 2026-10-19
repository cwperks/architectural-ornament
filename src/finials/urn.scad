use <../profiles/moldings.scad>

finial_height = 140;
base_diameter = 50;
mounting_hole_diameter = 0;
facets = 160;

function transition(r1, r2, z1, z2, steps = 40) = [
    for (i = [1:steps])
        [r1 + (r2 - r1) * molding_shape("ogee", i / steps), z1 + (z2 - z1) * i / steps]
];

module urn_finial(height, diameter, hole = 0, resolution = 160) {
    assert(height > 0 && diameter > 0 && resolution >= 16);
    assert(hole >= 0 && hole < diameter * 0.3, "Mounting hole must be smaller than 30% of base diameter");
    r = diameter / 2;
    difference() {
        rotate_extrude($fn = resolution, convexity = 10)
            polygon(concat(
                [[0, 0], [r * 0.9, 0], [r, height * 0.02], [r, height * 0.08]],
                transition(r, r * 0.35, height * 0.08, height * 0.25),
                [for (i = [0:32])
                    [r * (0.35 + 0.12 * molding_shape("bead", i / 32)), height * (0.28 + 0.05 * i / 32)]],
                transition(r * 0.35, r * 1.15, height * 0.33, height * 0.55),
                transition(r * 1.15, r * 0.42, height * 0.55, height * 0.80),
                [for (i = [1:32])
                    [r * (0.42 + 0.3 * molding_shape("bead", i / 32)), height * (0.80 + 0.09 * i / 32)]],
                transition(r * 0.42, 0, height * 0.89, height)
            ));
        if (hole > 0)
            translate([0, 0, -1])
                cylinder(h = height * 0.18 + 1, d = hole, $fn = resolution);
    }
}

// A capped, solid ornament, not a hollow vessel.
color([0.48, 0.25, 0.08])
    urn_finial(finial_height, base_diameter, mounting_hole_diameter, facets);
