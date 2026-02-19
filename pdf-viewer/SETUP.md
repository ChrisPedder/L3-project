# PDF Viewer – Setup Guide

This directory adds a lightweight PDF viewer with page-level commenting to the
existing GitHub Pages site. It uses **vanilla HTML/CSS/JS** with no build tools;
all libraries are loaded from CDNs.

---

## 1. Deploy alongside the slides

The existing GitHub Actions workflow (`deploy-slides.yml`) uploads only the
`slides/` directory. To deploy **both** `slides/` and `pdf-viewer/` you need to
change the artifact path to the repository root.

Open `.github/workflows/deploy-slides.yml` and change:

```yaml
path: './slides'
```

to:

```yaml
path: '.'
```

> **Note:** This will expose every committed file at the root to GitHub Pages.
> If you'd prefer to keep the deployment scoped, you can instead create a small
> build step that copies `slides/` and `pdf-viewer/` into a temporary directory
> and upload that.

After making this change the site structure will be:

| URL path              | Content              |
|-----------------------|----------------------|
| `/slides/`            | Reveal.js slides     |
| `/pdf-viewer/`        | PDF index & viewers  |

---

## 2. Add a new PDF

1. **Place the PDF file** in a sensible location, for example:
   ```
   pdf-viewer/docs/my-document.pdf
   ```
   You can also use an external URL if the PDF is hosted elsewhere.

2. **Create a viewer page.** Copy `example.html` to a new file (e.g.
   `my-document.html`) and update two things:
   - The `<title>` and heading text.
   - The `PDF_URL` variable near the top of the `<script>` block:
     ```js
     const PDF_URL = "docs/my-document.pdf";
     ```

3. **Add a link on the index page.** Open `index.html` and add a new `<li>`
   inside the `<ul class="pdf-list">` list:
   ```html
   <li>
     <a href="my-document.html">
       <span class="pdf-title">My Document</span>
       <span class="pdf-desc">A short description of the document.</span>
     </a>
   </li>
   ```

4. **Commit and push.** GitHub Actions will deploy the updated site
   automatically.

---

## 3. Configure Giscus (comment widget)

[Giscus](https://giscus.app) uses GitHub Discussions as a backend for comments.

### Prerequisites

1. **Install the Giscus app** on the repository:
   <https://github.com/apps/giscus>
2. **Enable GitHub Discussions** on the repository:
   *Settings → General → Features → Discussions* (tick the box).
3. **Create a Discussion category** for comments (e.g. "Announcements" or a
   custom "PDF Comments" category).

### Fill in your settings

1. Visit <https://giscus.app> and enter your repository details. The
   configurator will give you the four required values.
2. Open **`giscus-config.js`** and replace the placeholder values:

   ```js
   repo:       "YOUR_GITHUB_USERNAME/YOUR_REPO_NAME",
   repoId:     "YOUR_REPO_ID",
   category:   "Announcements",
   categoryId: "YOUR_CATEGORY_ID",
   ```

3. Adjust optional settings (theme, language, etc.) if desired.

That's it — every viewer page loads `giscus-config.js` automatically, so you
only need to edit this file once.

---

## 4. Optional: Hypothes.is for inline PDF annotations

[Hypothes.is](https://web.hypothes.is) provides collaborative, inline
annotation directly on top of web content, including embedded PDFs. It is
independent of Giscus and can be used alongside or instead of it.

To enable Hypothes.is on a viewer page, add the following single line before the
closing `</body>` tag:

```html
<script src="https://hypothes.is/embed.js" async></script>
```

No account setup or API keys are required — annotations are stored by the
Hypothes.is service. Visitors can annotate publicly or privately once they
create a free Hypothes.is account.

> **Tip:** If you want Hypothes.is on *every* viewer page, add the script line
> to the template you copy when creating new pages.

---

## 5. Dependencies & assumptions

| Dependency | Loaded from | Version |
|------------|-------------|---------|
| PDF.js     | cdnjs CDN   | 4.4.168 |
| Giscus     | giscus.app  | latest  |

- **No build tools** are required. All files are plain HTML, CSS, and JS.
- The site must be served over **HTTPS** (GitHub Pages provides this by
  default).
- PDF files must be accessible from the same origin or served with appropriate
  CORS headers if hosted externally.
- The viewer renders PDFs onto a `<canvas>` element via PDF.js. Very large PDFs
  may be slow on mobile devices; for those cases consider also offering a direct
  download link.

---

## 6. File overview

```
pdf-viewer/
├── SETUP.md              ← This file
├── giscus-config.js      ← Centralised Giscus settings (edit once)
├── style.css             ← Shared styles for all viewer pages
├── index.html            ← Lists all available PDFs
├── example.html          ← Sample viewer page (copy this for new PDFs)
└── docs/                 ← Suggested location for PDF files
    └── (your PDFs here)
```
