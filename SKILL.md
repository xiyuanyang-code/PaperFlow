# LaTeX Document Skill

You are a LaTeX document expert. This skill file defines how you create, compile, and manage LaTeX documents in this project.

---

## 1. Environment Setup & Verification

Before any LaTeX work, verify the TeX environment is available:

```bash
# Check pdflatex / xelatex availability
which pdflatex && pdflatex --version | head -1
which xelatex && xelatex --version | head -1

# Check bibtex / biber
which bibtex && which biber

# Check common tools
which pdftoppm && which pdfinfo   # poppler-utils
which latexmk                      # latexmk (optional, for auto multi-pass)
```

If missing, the compile script at `docs/document_skills/scripts/compile_latex.sh` can auto-install texlive. Run:
```bash
bash docs/document_skills/scripts/compile_latex.sh document.tex --preview
```

**Engine auto-detection rules:**
- Uses `fontspec`, `xeCJK`, or `polyglossia` → **xelatex**
- Uses `luacode` or `luatextra` → **lualatex**
- Otherwise → **pdflatex**

---

## 2. Workspace Setup

### Workspace: `workspace/`

All `.tex` editing and compilation happens in `workspace/`. Use `\input{}` or `\include{}` to organize multi-file documents.

```
workspace/
├── main.tex              # Primary document (entry point)
├── chapters/             # \input{chapters/intro.tex}
├── figures/              # Images and diagrams
├── references.bib        # Bibliography database
└── outputs/              # Generated PDFs go here
```

**Rules:**
1. **Never compile outside `workspace/`** — all `.tex` files stay here
2. **Clean auxiliary files after compilation** — remove `.aux`, `.log`, `.nav`, `.out`, `.snm`, `.toc`, `.vrb`, `.bbl`, `.blg`, `.fdb_latexmk`, `.fls` after each build
3. **Keep PDF and .tex in `workspace/`** — do not scatter output files elsewhere

### Document Area: `docs/`

Read `docs/document_skills/references/` guides as needed for specific tasks. Check `docs/document_skills/assets/templates/` for template starting points.

See [document](docs/README.md) for more detailed guidance.

### Reference Area: `reference/`

This is where you store reusable reference materials for document generation. Check `reference/README.md` for the full list of what to put here — experiment reports, assignment requirements, writing preferences, BibTeX libraries, style guides, and past documents as examples. The agent reads this directory before writing to maintain consistency with your personal style and accumulated materials.


## 3. Document Creation Workflow

| User Request | Template | Class |
|---|---|---|
| Resume / CV | `resume-*.tex` (6 options) | `article` |
| Thesis / dissertation | `thesis.tex` | `book` |
| Academic paper | `academic-paper.tex` | `article` |
| Academic CV | `academic-cv.tex` | `article` |
| Lecture notes | `lecture-notes.tex` | `scrartcl` |
| Homework / assignment | `homework.tex` | `article` |
| Lab report | `lab-report.tex` | `article` |
| Report / analysis | `report.tex` | `article` |
| Presentation / slides | `presentation.tex` | `beamer` |
| Book | `book.tex` | `book` |
| Scientific poster | `poster.tex` / `poster-landscape.tex` | `tikzposter` |
| Cheat sheet | `cheatsheet*.tex` (3 variants) | `extarticle` |
| Exam / quiz | `exam.tex` | `exam` |
| Business letter | `letter.tex` | `article` |
| Cover letter | `cover-letter.tex` | `article` |
| Invoice | `invoice.tex` | `article` |
| Fillable form | `fillable-form.tex` | `article` |

- Copy Template & Customize

```bash
cp docs/document_skills/assets/templates/report.tex workspace/main.tex
```

- Writing and Compile

```bash
# Basic compile (auto-detects engine, bibliography, index)
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex

# With PNG preview
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --preview

# Force engine
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --engine xelatex

# Use latexmk for complex documents
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --use-latexmk --preview

# PDF/A output (for thesis submissions)
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --pdfa

# Auto-fix common errors
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --auto-fix

# Clean auxiliary files only
bash docs/document_skills/scripts/compile_latex.sh workspace/main.tex --clean
```

- After compilation, deliver the PDF to the user.


## 4. Common Errors & Quick Fixes

| Error | Cause | Fix |
|---|---|---|
| `Undefined control sequence` | Typo or missing `\usepackage` | Check spelling; add package |
| `Missing $ inserted` | Math in text mode | Wrap with `$...$` |
| `Environment X undefined` | Missing package | Add `\usepackage{...}` |
| `Extra alignment tab &` | Too many `&` in table | Match column count |
| `File X not found` | Wrong path/filename | Check path, case, extension |
| `\begin{X} ended by \end{Y}` | Mismatched environments | Match begin/end names |
| `Option clash for package X` | Package loaded twice | Use `\PassOptionsToPackage` |
| `Unknown float option 'H'` | Missing float package | Add `\usepackage{float}` |
| `Overfull \hbox` | Content exceeds margin | Use `\url{}`, scale tables, `breaklines` |
| `Unicode char not set up` | Non-ASCII in pdflatex | Use xelatex or replace with LaTeX command |
| `Dimension too large` | TikZ/pgfplots coordinates too big | Scale down; use scientific notation |
| `Runaway argument?` | Missing closing `}` | Search upward for unclosed brace |
| `Not in outer par mode` | Float inside float | Use subfigure; don't nest floats |

- Silent Failures (No Error, Wrong Output)

| You Write | PDF Shows | Fix |
|---|---|---|
| `<5%` in text | `¿5%` | `$<$5\%` |
| `>50` in text | `¡50` | `$>$50` |
| `~` in text | nothing/tilde | `\textasciitilde` |
| `\` in text | starts command | `\textbackslash` |

- Debugging Workflow

```bash
# 1. Check for errors
grep "^!" document.log

# 2. Check for warnings
grep -i "warning" document.log | head -10

# 3. Check overfull boxes
grep "Overfull" document.log

# 4. Use lacheck for syntax
lacheck document.tex

# 5. Use chktex for style
chktex -n 1 -n 8 document.tex
```

**Fix errors top-to-bottom** — early errors cascade into false errors below.

---

*This file condenses 26 reference guides, 27 templates, and 27 scripts from `docs/document_skills/` into a single actionable prompt. For deep dives on any topic, read the corresponding file in `docs/document_skills/references/`.*
