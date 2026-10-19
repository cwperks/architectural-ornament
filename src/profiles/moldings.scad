// Normalized section shapes, shared by straight samples and turned collars.
function molding_shape(kind, t) =
    kind == "fillet" ? 1 :
    kind == "bead" ? sin(180 * t) :
    kind == "cove" ? 1 - sqrt(max(0, 1 - t * t)) :
    kind == "ogee" ? t * t * (3 - 2 * t) :
    assert(false, str("Unknown molding profile: ", kind)) 0;

function molding_section(kind, width, height, steps = 48) = [
    for (i = [0:steps]) [width * i / steps, height * molding_shape(kind, i / steps)]
];
