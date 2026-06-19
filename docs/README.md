## Reference LaTeX Documentations

```
docs/
├── debug/                          # Debugging guides (font_managing.md, installation_debug.md)
├── document_skills/                # Main LaTeX skill repository
│   ├── SKILL.md                    # Original skill definition (full prompt)
│   ├── README.md                   # Project overview with template gallery
│   ├── setup.sh                    # One-click installer for all dependencies
│   ├── .chktexrc                   # chktex configuration
│   ├── templates/                  # 28 production-tested .tex templates
│   │   ├── resume.tex              # Classic resume
│   │   ├── resume-classic-ats.tex  # ATS-optimized classic resume
│   │   ├── resume-entry-level.tex  # Entry-level resume
│   │   ├── resume-executive.tex    # Executive resume
│   │   ├── resume-modern-professional.tex # Modern professional resume
│   │   ├── resume-technical.tex    # Technical resume
│   │   ├── thesis.tex              # Full book-class thesis
│   │   ├── academic-paper.tex      # Research paper (arXiv-compatible)
│   │   ├── academic-cv.tex         # Multi-page academic CV
│   │   ├── lecture-notes.tex       # Color-coded theorem environments
│   │   ├── homework.tex            # Assignment with solution toggle
│   │   ├── lab-report.tex          # STEM lab report
│   │   ├── book.tex                # Full-length book (37+ pages)
│   │   ├── poster.tex              # Portrait conference poster (tikzposter)
│   │   ├── poster-landscape.tex    # Landscape poster
│   │   ├── cheatsheet.tex          # General reference card
│   │   ├── cheatsheet-exam.tex     # Exam reference card
│   │   ├── cheatsheet-code.tex     # Code reference card
│   │   ├── exam.tex                # Exam/quiz with grading table
│   │   ├── report.tex              # Business report with charts/flowcharts
│   │   ├── presentation.tex        # Beamer 16:9 slides
│   │   ├── letter.tex              # Formal business letter
│   │   ├── cover-letter.tex        # Job application cover letter
│   │   ├── invoice.tex             # Professional invoice
│   │   ├── fillable-form.tex       # PDF form with hyperref fields
│   │   ├── conditional-document.tex # Toggles via etoolbox
│   │   ├── mail-merge-letter.tex   # Template for mail merge
│   │   └── references.bib          # Example BibTeX entries
│   ├── scripts/                    # 28 automation scripts
│   │   ├── compile_latex.sh        # .tex → PDF + PNG (auto-detect engine)
│   │   ├── generate_chart.py       # 9 chart types from JSON/CSV (matplotlib)
│   │   ├── csv_to_latex.py         # CSV → LaTeX table
│   │   ├── mail_merge.py           # Template + CSV → N personalized PDFs
│   │   ├── latex_diff.sh           # Version diffing (latexdiff + git)
│   │   ├── fetch_bibtex.sh         # DOI/arXiv → BibTeX entries
│   │   ├── validate_latex.py       # 6-check syntax validator
│   │   ├── latex_lint.sh           # chktex wrapper
│   │   ├── latex_analyze.sh        # Document statistics
│   │   ├── latex_wordcount.sh      # Word count via detex
│   │   ├── latex_package_check.sh  # Pre-flight package verification
│   │   ├── latex_citation_extract.sh # Citation analysis
│   │   ├── convert_document.sh     # Pandoc format conversion
│   │   ├── mermaid_to_image.sh     # .mmd → PNG/PDF
│   │   ├── graphviz_to_pdf.sh      # .dot → PDF/PNG
│   │   ├── plantuml_to_pdf.sh      # .puml → PDF/PNG/SVG
│   │   ├── install_deps.sh         # Dependency installer helper
│   │   ├── pdf_to_images.sh        # PDF → page images (for OCR)
│   │   ├── pdf_encrypt.sh          # AES-256 encryption
│   │   ├── pdf_merge.sh            # Combine PDFs
│   │   ├── pdf_optimize.sh         # Compress for web/email
│   │   ├── pdf_extract_pages.sh    # Extract page ranges
│   │   ├── pdf_check_form.py       # Detect fillable form fields
│   │   ├── pdf_extract_fields.py   # Form field metadata
│   │   ├── pdf_fill_form.py        # Fill fillable forms
│   │   ├── pdf_fill_annotations.py # Fill non-fillable forms
│   │   └── pdf_validate_boxes.py   # Bounding box validation
│   └── references/                 # 28 deep-dive guides
│       ├── beamer-guide.md         # Themes, overlays, code slides, handouts
│       ├── bibliography-guide.md   # BibTeX vs biblatex, citation styles
│       ├── charts-and-graphs.md    # pgfplots (line, bar, scatter, pie)
│       ├── cheatsheet-guide.md     # Cheatsheet layout and design
│       ├── code-patterns.md        # 16 ready-to-use LaTeX snippets
│       ├── collaboration-guide.md  # Multi-author workflows
│       ├── debugging-guide.md      # 20 common errors, .log analysis
│       ├── font-guide.md           # Font families, fontspec, CJK
│       ├── format-conversion.md    # Document format conversion
│       ├── graphviz-plantuml.md    # Graphviz and PlantUML integration
│       ├── ieee-journal-twocolumn-guide.md # IEEE two-column layout
│       ├── interactive-features.md # Hyperlinks, forms, toggles
│       ├── long-form-best-practices.md # 9 anti-patterns for 5+ page docs
│       ├── mermaid-diagrams.md     # Mermaid diagram integration
│       ├── packages.md             # Common package reference
│       ├── pdf-conversion.md       # PDF conversion techniques
│       ├── pdf-extraction-prompts.md # PDF content extraction
│       ├── pdf-operations.md       # PDF manipulation operations
│       ├── poster-design-guide.md  # Poster layout and design
│       ├── python-charts.md        # Python chart generation
│       ├── qa-test-report.md       # QA testing methodology
│       ├── resume-ats-guide.md     # ATS optimization guide
│       ├── script-tools.md         # PDF utilities, quality tools
│       ├── tables-and-images.md    # Colored rows, booktabs, subfigures
│       ├── visual-packages.md      # 24 TikZ/visualization packages
│       ├── advanced-features.md    # Watermarks, landscape, algorithms
│       ├── accessibility-guide.md  # PDF/A, PDF/UA, tagged PDFs
│       └── profiles/               # 4 OCR conversion profiles
│           ├── math-notes.md       # Equations, theorems, proofs
│           ├── business-document.md # Reports, financials
│           ├── legal-document.md   # Contracts, statutes
│           └── general-notes.md    # Handwritten, mixed content
```
