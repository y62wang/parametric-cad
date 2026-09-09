# Parametric CAD projects

This repository is organized around printable projects rather than a single
shared export folder. Each project keeps its description, source, printable
files, and any validation or assembly notes together.

## Projects

| Project | Description | Status |
|---|---|---|
| [Badminton racket wall hook](projects/badminton-racket-wall-hook/) | Side-entry snap rack for up to eight racket shafts | Printable prototype |
| [Chicken low-waste feeder](projects/chicken-low-waste-feeder/) | Large gravity feeder with two head ports and an internal baffle | Printable prototype |
| [Kallax drawer system](projects/kallax-drawer-system/) | Split drawer panels, connectors, and printable dovetail rails | Work in progress |
| [Model Y Juniper trunk hook](projects/model-y-juniper-trunk-hook/) | Three-loop grocery hook with weatherstrip fit coupons | Digital validation complete; car fit pending |
| [Parametric desk organizer](projects/parametric-desk-organizer/) | Configurable boxes, inserts, layouts, and a 15-slot holder | Toolkit and printable example |

## Project layout

Each publishable project follows the same basic structure:

```text
project-name/
├── README.md        Project-page description, print settings, and usage
├── src/             Editable OpenSCAD source
├── files/           Printable 3MF exports
├── tests/           Optional OpenSCAD tests
└── SPEC.md          Optional design specification
```

New project descriptions should follow
[`docs/PROJECT_TEMPLATE.md`](docs/PROJECT_TEMPLATE.md).

## Libraries

- [`parametric_screws/`](parametric_screws/) — reusable screw-generation and
  print-plate utilities.

`parametric_todo.md` remains the backlog for future reusable CAD components.
