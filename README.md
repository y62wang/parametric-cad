# Parametric CAD projects

This repository is organized around printable projects rather than a single
shared export folder. Each project keeps its description, source, printable
files, and any validation or assembly notes together.

All CAD source and exports live under `projects/`. The repository root is
reserved for this index, shared documentation, and repository configuration.

## Projects

| Project | Description | Status |
|---|---|---|
| [Badminton racket wall hook](projects/badminton-racket-wall-hook/) | Side-entry snap rack for up to eight racket shafts | Printable prototype |
| [Chicken low-waste feeder](projects/chicken-low-waste-feeder/) | Large gravity feeder with two head ports and an internal baffle | Printable prototype |
| [Kallax drawer system](projects/kallax-drawer-system/) | Split drawer panels, connectors, and printable dovetail rails | Work in progress |
| [Model Y Juniper trunk hook](projects/model-y-juniper-trunk-hook/) | Three-loop grocery hook with weatherstrip fit coupons | Digital validation complete; car fit pending |
| [Parametric CAD library](projects/parametric-cad-library/) | Config-driven screw geometry and print-bed packing utilities | Reusable toolkit |
| [Parametric desk organizer](projects/parametric-desk-organizer/) | Configurable boxes, inserts, layouts, and a 15-slot holder | Toolkit and printable example |

## Project layout

Each publishable project follows the same basic structure:

```text
project-name/
├── README.md        Project-page description, print settings, and usage
├── src/             Editable OpenSCAD source
├── files/           Printable 3MF exports
├── data/            Optional standards tables or source data
├── tests/           Optional OpenSCAD tests
├── SPEC.md          Optional design specification
└── BACKLOG.md       Optional project roadmap
```

New project descriptions should follow
[`docs/PROJECT_TEMPLATE.md`](docs/PROJECT_TEMPLATE.md).
