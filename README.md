# dubilava.github.io
personal website

## Resume build

Use the helper script in `resume/` to rebuild the CV PDFs:

```powershell
powershell -ExecutionPolicy Bypass -File .\resume\build-resume.ps1
```

Pass `-Target Ubilava-CV-Short` or `-Target Ubilava-pubs` to build the other variants.

The script clears stale LaTeX byproducts for the chosen target before running
`pdflatex -> biber -> pdflatex -> pdflatex`, which avoids failures caused by
old `.bbl`/`.bcf` files after TeX package upgrades.
