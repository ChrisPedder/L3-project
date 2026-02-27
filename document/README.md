# L3 Design Document

This directory contains the Level 3 certification design document in Markdown format. A GitHub Actions workflow automatically builds it to PDF whenever changes are pushed.

## Directory Structure

```
document/
├── L3_Design_Document.md     # Source document (edit this)
├── L3_Design_Document.pdf    # Auto-generated PDF (do not edit)
├── images/                   # Document-specific images (wiring diagrams, OR screenshots, etc.)
└── README.md                 # This file
```

Build photographs are stored in `../slides/images/` and referenced with relative paths.

## Building Locally

To build the PDF on your machine:

```bash
# Install pandoc and LaTeX (macOS)
brew install pandoc
brew install --cask mactex-no-gui

# Install pandoc and LaTeX (Ubuntu/Debian)
sudo apt-get install pandoc texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended lmodern

# Build
cd document
pandoc L3_Design_Document.md \
  -o L3_Design_Document.pdf \
  --pdf-engine=pdflatex \
  --toc \
  --number-sections \
  -V geometry:margin=2.5cm \
  -V fontsize=11pt \
  -V documentclass=article \
  -V colorlinks=true \
  -V linkcolor=blue \
  -V urlcolor=blue \
  --highlight-style=tango \
  --standalone
```

## Automated Builds

The GitHub Actions workflow at `.github/workflows/build-pdf.yml` builds the PDF on every push to the `document/` directory and commits the result back to the repository. The built PDF is also copied to `pdf-viewer/docs/` for viewing on the project site.

## Image References

The document references images from two locations:

- `images/` — document-specific figures (wiring diagrams, OpenRocket screenshots, simulation plots). You will need to export these from the original Word document or take fresh screenshots.
- `../slides/images/` — build photographs from the construction log slides.

## Required Images to Add

The following images are referenced in the markdown but need to be placed in the `document/images/` directory. These correspond to figures from the original Word document:

| Filename | Description |
|:---|:---|
| `wiring_diagram.png` | Recovery electronics wiring schematic |
| `deployment_flow.gif` | Parachute deployment sequence animation |
| `fin_profile.png` | Fin profile dimensions drawing |
| `or_no_motor.png` | OpenRocket model screenshot (no motor) |
| `or_with_motor.png` | OpenRocket model screenshot (with M1550) |
| `vertical_motion.png` | Altitude vs time plot (M1550) |
| `ground_track.png` | Ground track plot (M1550) |
| `nose_tip_test.jpg` | 3D-printed ABS nose tip test piece photo |
