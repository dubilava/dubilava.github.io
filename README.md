# davidubilava.com

Personal academic website built with [Quarto](https://quarto.org/) and hosted
with GitHub Pages.

## Website preview

Render the site into the repository root for GitHub Pages:

```powershell
quarto render
```

For a live local preview while editing:

```powershell
quarto preview
```

The generated HTML and supporting assets are committed alongside the Quarto
source so GitHub Pages can serve the site directly from the `master` branch.

## Resume build

Use the helper script in `resume/` to rebuild the CV PDFs:

```powershell
powershell -ExecutionPolicy Bypass -File .\resume\build-resume.ps1
```

Pass `-Target Ubilava-CV-Short` or `-Target Ubilava-pubs` to build the other variants.

The script clears stale LaTeX byproducts for the chosen target before running
`pdflatex -> biber -> pdflatex -> pdflatex`, which avoids failures caused by
old `.bbl`/`.bcf` files after TeX package upgrades.
