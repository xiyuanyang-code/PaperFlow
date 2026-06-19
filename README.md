# PaperFlow

## Introduction

- Experiment code, structural analysis, and logs are scattered across remote servers.
- Overleaf runs in the cloud, and the free tier limits compile time with no git support.

`PaperFlow` is a lightweight, out-of-the-box agent-writing-toolbox:

- One-click installation of fonts & TeX dependencies — no repetitive manual setup
- Built-in high-quality skills to improve agent writing quality
- Non-invasive design, purpose-built for the above scenarios

## Usage for Humans

### Step1 Installing Environments via `TinyTex`

You can pass two optional arguments to install tex and other prequisities:

```bash
curl -fsSL https://raw.githubusercontent.com/xiyuanyang-code/PaperFlow/main/scripts/install.sh | bash -s -- [INSTALL_DIR] [TINYTEX_INSTALLER]
# original install files in scripts/install.sh

# for example, if you want to install full tex environments (like in overleaf)
# you can use following commands:
curl -fsSL https://raw.githubusercontent.com/xiyuanyang-code/PaperFlow/main/scripts/install.sh | bash -s -- [INSTALL_DIR] TinyTeX-2
```

| Argument             | Description                         | Default           |
| -------------------- | ----------------------------------- | ----------------- |
| `INSTALL_DIR`        | Where to install TinyTeX            | `$HOME/.TinyTeX`  |
| `TINYTEX_INSTALLER`  | Installer variant [Detailed releases](https://github.com/rstudio/tinytex-releases)                  | `TinyTeX-1`       |

Supported installer:
-   `TinyTeX-0` contains the `infraonly` scheme of TeX Live, without any LaTeX
    packages. This is the smallest bundle. If you install this bundle, you may
    install any other packages via `tlmgr` (which is a utility included in this
    variation), e.g., `tlmgr install latex-bin framed`.

-   `TinyTeX-1` contains [about 100 LaTeX
    packages](https://github.com/rstudio/tinytex/blob/main/tools/pkgs-custom.txt)
    enough to compile common R Markdown documents (which was the original
    motivation of the TinyTeX project).

-   `TinyTeX` contains [more LaTeX
    packages](https://github.com/rstudio/tinytex/blob/main/tools/pkgs-yihui.txt)
    requested by the community. The list of packages may grow as time goes by,
    and the size of this bundle will grow correspondingly.

-   `TinyTeX-2` contains the `scheme-full` scheme of TeX Live, which means all
    LaTeX packages that you could possibly install from CTAN. This is the
    largest bundle, and only available in the [daily
    release](https://github.com/rstudio/tinytex-releases/releases/daily).

### Step2 Cloning Repos

Create a `papers` folder in your current working directory to focus on paper writing:

```bash
git clone git@github.com:xiyuanyang-code/PaperFlow.git ./papers
cd ./papers
```

### Step3 Enjoying the Writing

Use Claude or Codex to assist with writing tasks:

- The agent reads `SKILL.md` to understand the repository structure and the paper-writing workflow.

Workspace conventions:

- Core `.tex` writing files are managed by the agent inside the `workspace/` subfolder.
- You can place essential reference materials — experiment code insights, structural summaries, etc. — in the `reference/` folder. The agent will browse this directory before writing.
- The `docs/` folder contains built-in latex-skills manuals and guides.
    - Reference: https://github.com/ndpvt-web/latex-document-skill

## Usage for Agents

See [SKILL.md](SKILL.md)