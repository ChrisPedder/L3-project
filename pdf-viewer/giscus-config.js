/*
 * Giscus Configuration
 * ====================
 * This file centralises all Giscus comment widget settings.
 * Edit the values below, then every viewer page will pick them up automatically.
 *
 * Before this will work you must:
 *   1. Install the Giscus GitHub App on your repository:
 *      https://github.com/apps/giscus
 *   2. Enable GitHub Discussions on your repository:
 *      Repository -> Settings -> General -> Features -> Discussions (tick the box)
 *   3. Visit https://giscus.app to generate your configuration values,
 *      then paste them into the object below.
 *
 * The "repo", "repoId", "category", and "categoryId" fields are REQUIRED.
 * You can obtain all four from the configurator at https://giscus.app.
 */

const GISCUS_CONFIG = {
  // REQUIRED -- replace these placeholder values with your own
  repo:       "ChrisPedder/L3-project",
  repoId:     "R_kgDOQY5Z6A",
  category:   "PDF Comments",          // or whichever Discussion category you chose
  categoryId: "DIC_kwDOQY5Z6M4C2xum",

  // Optional -- sensible defaults are provided
  mapping:       "pathname",             // maps each page URL to a Discussion thread
  strict:        "0",                    // 0 = fuzzy matching, 1 = exact
  reactionsEnabled: "1",                 // show reaction emojis
  emitMetadata:  "0",                    // do not emit metadata events
  inputPosition: "top",                  // comment box above existing comments
  theme:         "light",                // light | dark | preferred_color_scheme
  lang:          "en",                   // interface language
  loading:       "lazy"                  // defer loading until widget is near viewport
};

/*
 * injectGiscus(containerSelector)
 * --------------------------------
 * Call this function from any viewer page to inject the Giscus <script> tag
 * into the element that matches `containerSelector` (default: ".giscus-container").
 */
function injectGiscus(containerSelector) {
  const target = document.querySelector(containerSelector || ".giscus-container");
  if (!target) return;

  const script  = document.createElement("script");
  script.src    = "https://giscus.app/client.js";
  script.setAttribute("data-repo",               GISCUS_CONFIG.repo);
  script.setAttribute("data-repo-id",            GISCUS_CONFIG.repoId);
  script.setAttribute("data-category",           GISCUS_CONFIG.category);
  script.setAttribute("data-category-id",        GISCUS_CONFIG.categoryId);
  script.setAttribute("data-mapping",            GISCUS_CONFIG.mapping);
  script.setAttribute("data-strict",             GISCUS_CONFIG.strict);
  script.setAttribute("data-reactions-enabled",   GISCUS_CONFIG.reactionsEnabled);
  script.setAttribute("data-emit-metadata",       GISCUS_CONFIG.emitMetadata);
  script.setAttribute("data-input-position",      GISCUS_CONFIG.inputPosition);
  script.setAttribute("data-theme",              GISCUS_CONFIG.theme);
  script.setAttribute("data-lang",               GISCUS_CONFIG.lang);
  script.setAttribute("data-loading",            GISCUS_CONFIG.loading);
  script.crossOrigin = "anonymous";
  script.async       = true;

  target.appendChild(script);
}
