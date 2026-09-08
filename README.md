# Architectural Ornament

Parametric, version-controlled architectural components for digital fabrication and traditional casting workflows.

The first model is an acorn fence finial intended as a printable master. Dimensions are expressed in millimeters and can be overridden from the OpenSCAD command line.

![Rendered acorn fence finial](renders/acorn-finial.png)

## Requirements

- [OpenSCAD](https://openscad.org/)
- GNU Make

## Render the first model

```bash
make
make preview
```

Generated files are written to `build/`:

- `build/acorn-finial.stl` for slicing or fabrication
- `build/acorn-finial.png` for visual review

Override model parameters without editing the source:

```bash
openscad \
  -D 'finial_height=140' \
  -D 'base_diameter=52' \
  -D 'mounting_hole_diameter=18' \
  -o build/acorn-finial-140mm.stl \
  src/finials/acorn.scad
```

## Initial direction

1. Print and evaluate the acorn finial at full scale.
2. Tune proportions, mounting geometry, and minimum wall thickness.
3. Add spear and urn variants built from shared profiles.
4. Experiment with printed masters and silicone molds.
5. Introduce mesh-based tools when ornament becomes too organic for constructive solid geometry.
