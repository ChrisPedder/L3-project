# L3-project

Repository to allow my TAPs to follow along with my Level III Tripoli rocket build.

## 💬 TAPs – How to Leave Feedback on Documents

You can comment directly on specific sections of any PDF document hosted on this site. Here's how:

1. **Open a document** — go to the [PDF Documents](https://chrispedder.github.io/L3-project/pdf-viewer/) page and click the document you want to review.
2. **Select some text** — highlight the word, sentence, or passage you want to comment on.
3. **Click "Annotate"** — a small tooltip will appear. Click it to open the annotation editor.
4. **Sign in** — you'll need a free [Hypothes.is account](https://hypothes.is/signup). Sign up takes a moment and only needs to be done once.
5. **Write your comment** and click "Post". Your annotation will be anchored to the exact text you selected.

You can also open the Hypothes.is sidebar (the small `<` tab in the top-right corner of the page) to browse all existing annotations.

> **General comments** that aren't about a specific passage can be left in the Giscus discussion widget at the bottom of each document page. These use your GitHub account.

## 🚀 Project Overview

This repository documents my Level 3 High Power Rocketry (HPR) certification attempt with the Tripoli Rocketry Association. It serves as a comprehensive build log and technical reference for my Technical Advisor Panel (TAPs) to review progress, provide feedback, and verify compliance with certification requirements.

The rocket is a sport-scale model of the Canadian Black Brant II sounding rocket, built on a 6-inch Madcow fibreglass airframe with redundant dual-deploy recovery.

## 🔧 Rocket Specifications

| Parameter | Value |
|-----------|-------|
| **Name** | Black Brant 6″ Scale Model |
| **Motor** | Aerotech M1550 (75/6400 casing) |
| **Total Impulse** | 5600 Ns |
| **Airframe Diameter** | 15.5 cm (6″) |
| **Overall Length** | 284 cm |
| **Dry Mass** | 17.25 kg |
| **Pad Mass (with motor)** | 22.9 kg |
| **Fins** | 3× swept G10 fibreglass, 5 mm thick |
| **Motor Mount** | 98 mm (with 75 mm adapter) |
| **Nose Cone** | 5.2:1 conical fibreglass (Madcow) |
| **Recovery** | Dual-deploy: 120″ main + 36″ drogue (Fruity Chutes Iris Ultra) |
| **Electronics** | MissileWorks RRC3 (primary) + Altus Metrum EasyMini (backup) + Silicdyne Fluctus GPS |

### Simulated Performance (M1550, 5 m/s wind)

| Parameter | Value |
|-----------|-------|
| Max Altitude | 2075 m |
| Max Velocity | 215 m/s (Mach 0.64) |
| Thrust-to-Weight | 6.9:1 |
| Rail Departure Velocity | 22.6 m/s (3 m rail) |
| Stability Margin | 2.64 cal (at launch); 1.45 cal (at rail departure) |
| Landing Velocity | 4.32 m/s (main chute) |
| Total Flight Time | ~199 s |

## 📁 Repository Structure

```
L3-project/
├── document/                    # Design document (source of truth)
│   ├── L3_Design_Document.md    #   Markdown source — edit this
│   ├── L3_Design_Document.pdf   #   Auto-generated PDF (do not edit)
│   ├── images/                  #   Figures: wiring, fins, sims, profile
│   └── README.md                #   Document build instructions
├── slides/                      # Interactive build-log presentation
│   ├── index.html               #   Reveal.js viewer
│   ├── slides.md                #   Slide content (Markdown)
│   ├── images/                  #   Build photos
│   ├── videos/                  #   Build and test videos
│   └── README.md                #   Slides-specific docs
├── pdf-viewer/                  # Hosted PDF viewer with commenting
│   ├── index.html               #   PDF listing page
│   ├── example.html             #   L3 Design Document viewer
│   ├── giscus-config.js         #   Centralised Giscus comment settings
│   ├── style.css                #   Shared styles
│   ├── SETUP.md                 #   Setup and usage guide
│   └── docs/                    #   PDF files served on the site
├── ork_files/                   # OpenRocket simulation files
├── stl_files/                   # 3D-printable parts (nose tip, jigs)
├── .github/workflows/           # CI/CD pipelines
│   ├── build-pdf.yml            #   Build PDF from Markdown & deploy
│   └── deploy-slides.yml        #   Deploy site to GitHub Pages
├── BUILD.md                     # How the build system works
├── pyproject.toml               # Python/Jupyter environment (optional)
└── README.md                    # This file
```

## 🔗 Live Site

| Page | Link |
|------|------|
| **Interactive Slides** | [chrispedder.github.io/L3-project/slides/](https://chrispedder.github.io/L3-project/slides/) |
| **PDF Documents & Comments** | [chrispedder.github.io/L3-project/pdf-viewer/](https://chrispedder.github.io/L3-project/pdf-viewer/) |
| **L3 Design Document** | [chrispedder.github.io/L3-project/pdf-viewer/example.html](https://chrispedder.github.io/L3-project/pdf-viewer/example.html) |

## 📋 Documentation

### Interactive Slides
The primary documentation is available as an interactive presentation built with Reveal.js.
- **Local Viewing:** See [slides/README.md](slides/README.md) for instructions

### PDF Viewer
Design documents and other PDFs are hosted with an embedded viewer and a Giscus comment widget for discussion.
- **Adding new PDFs:** See [pdf-viewer/SETUP.md](pdf-viewer/SETUP.md) for instructions

### Contents
The documentation covers:
- Rocket specifications and design rationale
- Component selection and sourcing
- Build progress with photos
- Safety considerations
- Flight planning and simulations
- Recovery system design
- Electronics and avionics
- Pre-flight checklists

## 🎯 Certification Requirements

For L3 certification with Tripoli, this project demonstrates:
- Construction of a rocket using a motor requiring Level 3 certification (M impulse class or higher)
- Successful recovery of all components
- Documentation of the build process for TAP review
- Understanding of safety procedures and regulations

## 📊 Project Status

- [x] Design finalisation
- [x] Component procurement
- [x] Airframe construction
- [x] Fins and motor mount
- [ ] Recovery system
- [ ] Electronics bay
- [ ] Ground testing
- [ ] Final inspection
- [ ] Certification flight

## 👥 For TAP Reviewers

Thank you for taking the time to review my L3 project. The interactive slides provide detailed documentation of each build phase. If you have questions or feedback:

1. **View the slides:** [Interactive Slides](https://chrispedder.github.io/L3-project/slides/) — use arrow keys to navigate, ESC for overview mode
2. **View and comment on PDFs:** [PDF Documents](https://chrispedder.github.io/L3-project/pdf-viewer/) — leave comments via the Giscus widget below each document
3. **Provide feedback:** Open an issue or contact me directly

## 📚 Resources

- [Tripoli Rocketry Association](https://www.tripoli.org/)
- [Tripoli L3 Certification Process](https://www.tripoli.org/Level3)
- [OpenRocket](https://openrocket.info/) - Flight simulation software

## 📧 Contact

Chris Pedder
- GitHub: [@ChrisPedder](https://github.com/ChrisPedder)

## 📄 License

This project documentation is shared for educational purposes and TAP review. Please contact me before reusing any content.
