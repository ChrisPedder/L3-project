# Build System

This document explains how the project's build and deployment pipeline works.

## Overview

The project has two GitHub Actions workflows that build and deploy content to GitHub Pages:

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| **Build Design Document PDF** | `.github/workflows/build-pdf.yml` | Push to `document/**`, `slides/images/**`, or the workflow file itself | Builds the PDF from Markdown, then deploys the whole site |
| **Deploy Slides** | `.github/workflows/deploy-slides.yml` | Push to `main` | Deploys the entire repo to GitHub Pages |

Both workflows share a `"pages"` concurrency group so they never run in parallel.

## PDF Build Pipeline (`build-pdf.yml`)

This is the main workflow. It runs two jobs in sequence: **build-pdf** then **deploy-pages**.

### Job 1: `build-pdf`

1. **Checkout** the repository with Git LFS (PDF files are tracked via LFS — see `.gitattributes`).

2. **Install toolchain** — Pandoc, XeLaTeX, and ImageMagick:
   ```
   pandoc texlive-xetex texlive-latex-recommended texlive-latex-extra
   texlive-fonts-recommended texlive-fonts-extra fonts-dejavu lmodern
   imagemagick ghostscript
   ```

3. **Compress images** — ImageMagick resizes raster images (PNG/JPG) from two directories to reduce the final PDF size:
   - `slides/images/*.png` → max 1200x1200, quality 85
   - `document/images/*.{png,jpg,jpeg}` → max 1600x1600, quality 85
   - SVG files are left untouched (they are vector and already small).

4. **Build PDF with Pandoc** — Converts `document/L3_Design_Document.md` to PDF using XeLaTeX:
   ```bash
   pandoc L3_Design_Document.md \
     --resource-path=.:slides-compressed:images \
     -o L3_Design_Document.pdf \
     --pdf-engine=xelatex \
     --toc --number-sections \
     -V geometry:margin=2.5cm \
     -V fontsize=11pt \
     -V documentclass=article \
     -V colorlinks=true \
     -V linkcolor=blue -V urlcolor=blue \
     --highlight-style=tango --standalone
   ```
   The `--resource-path` flag tells Pandoc to look for images in the compressed directories first.

5. **Compress PDF with Ghostscript** — Reduces the PDF further using `/printer` quality settings at 200 DPI for images.

6. **Copy PDF to viewer** — Places the built PDF at `pdf-viewer/docs/L3 Design Document.pdf` so it is served on the website.

7. **Upload artifact** — Stores the PDF as a GitHub Actions artifact (retained 90 days).

8. **Commit back to repo** — Commits the generated PDF files to `main` using the `github-actions[bot]` identity. This means the PDF in the repo is always up to date with the latest source.

### Job 2: `deploy-pages`

Runs after `build-pdf` completes. It checks out `main` (now containing the freshly committed PDF), uploads the entire repo as a GitHub Pages artifact, and deploys it.

## Slides Deployment (`deploy-slides.yml`)

A simpler workflow that triggers on any push to `main`. It uploads the entire repo root to GitHub Pages and deploys it. In practice, the `build-pdf.yml` workflow handles deployment for document changes, and this workflow covers all other pushes.

## Image Sources

The design document Markdown references images from two locations:

| Path | Contents |
|------|----------|
| `document/images/` | Document-specific figures: wiring diagrams, OpenRocket screenshots, simulation plots, fin profiles |
| `slides/images/` | Build photographs used in the Reveal.js presentation |

The CI pipeline compresses both sets of images before embedding them in the PDF.

## Git LFS

PDF files are tracked with Git LFS (configured in `.gitattributes`):
```
*.pdf filter=lfs diff=lfs merge=lfs -text
```
This keeps the repository lightweight since the generated PDF is re-committed on each build.

## Building Locally

### Prerequisites

**macOS:**
```bash
brew install pandoc
brew install --cask mactex-no-gui
```

**Ubuntu/Debian:**
```bash
sudo apt-get install pandoc texlive-latex-recommended texlive-latex-extra \
  texlive-fonts-recommended lmodern
```

### Build the PDF

```bash
cd document
pandoc L3_Design_Document.md \
  -o L3_Design_Document.pdf \
  --pdf-engine=pdflatex \
  --toc --number-sections \
  -V geometry:margin=2.5cm \
  -V fontsize=11pt \
  -V documentclass=article \
  -V colorlinks=true \
  -V linkcolor=blue -V urlcolor=blue \
  --highlight-style=tango --standalone
```

Note: the local build uses `pdflatex` while CI uses `xelatex` (for broader Unicode/font support). Both produce equivalent output for this document.

### View the slides locally

```bash
cd slides
python -m http.server 8000
# Open http://localhost:8000
```

## Python Environment

A `pyproject.toml` and `uv.lock` are present for an optional Python/Jupyter environment (used for data analysis and simulation work, not for building the document). Install with:

```bash
uv sync
```
