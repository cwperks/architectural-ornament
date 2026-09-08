finial_height = 120;
base_diameter = 46;
mounting_hole_diameter = 0;
facets = 160;

function smoothstep(value) = value * value * (3 - 2 * value);

function acorn_body_profile(height, radius, steps = 96) = [
    for (step = [0:steps])
        let(
            progress = step / steps,
            lower_progress = min(progress / 0.28, 1),
            upper_progress = max((progress - 0.28) / 0.72, 0),
            radius_scale = progress < 0.28
                ? 0.84 + 0.16 * smoothstep(lower_progress)
                : 1 - 0.88 * smoothstep(upper_progress)
        )
        [radius * radius_scale, height * (0.46 + progress * 0.46)]
];

module acorn_finial(height, base_width, mounting_hole_width = 0, resolution = 160) {
    base_radius = base_width / 2;
    stem_radius = base_radius * 0.46;
    body_radius = base_radius * 0.91;

    difference() {
        rotate_extrude($fn = resolution, convexity = 10)
            polygon(
                concat(
                    [
                        [0, 0],
                        [base_radius - 2, 0],
                        [base_radius, height * 0.02],
                        [base_radius, height * 0.11],
                        [base_radius - 2, height * 0.14],
                        [stem_radius + 3, height * 0.17],
                        [stem_radius, height * 0.20],
                        [stem_radius, height * 0.28],
                        [stem_radius + 2, height * 0.30],
                        [body_radius * 0.72, height * 0.33],
                        [body_radius, height * 0.38],
                        [body_radius * 1.04, height * 0.43],
                        [body_radius * 0.88, height * 0.455],
                    ],
                    acorn_body_profile(height, body_radius),
                    [
                        [body_radius * 0.14, height * 0.95],
                        [body_radius * 0.12, height * 0.98],
                        [0, height],
                    ]
                )
            );

        if (mounting_hole_width > 0) {
            translate([0, 0, -1])
                cylinder(h = height * 0.22 + 1, d = mounting_hole_width, $fn = resolution);
        }
    }
}

color([0.48, 0.25, 0.08])
    acorn_finial(
        height = finial_height,
        base_width = base_diameter,
        mounting_hole_width = mounting_hole_diameter,
        resolution = facets
    );
