#!/usr/bin/env bash
#
# PaperFlow — TinyTeX One-Click Installer
# Usage: bash install.sh [INSTALL_DIR] [TINYTEX_INSTALLER]
#   INSTALL_DIR:         Installation path, default: $HOME/.TinyTeX
#   TINYTEX_INSTALLER:   Installer name, default: TinyTeX-1
#

set -euo pipefail

# ──────────────────────────────── Colors & Icons ────────────────────────────────

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

ICON_OK="${GREEN}✔${RESET}"
ICON_FAIL="${RED}✘${RESET}"
ICON_WARN="${YELLOW}⚠${RESET}"
ICON_INFO="${BLUE}ℹ${RESET}"
ICON_ROCKET="${MAGENTA}🚀${RESET}"
ICON_STAR="${YELLOW}★${RESET}"
ICON_GEAR="${CYAN}⚙${RESET}"

# ──────────────────────────────── Utilities ────────────────────────────────

banner() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║${RESET}  ${MAGENTA}${BOLD}T e x P a p e r${RESET}  ${DIM}— TinyTeX Installer${RESET}                    ${CYAN}║${RESET}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

step() {
    echo -e "\n${ICON_GEAR} ${BOLD}${BLUE}[$1/5]${RESET} ${WHITE}$2${RESET}"
    echo -e "${DIM}──────────────────────────────────────────────${RESET}"
}

info()    { echo -e "  ${ICON_INFO} $1"; }
ok()      { echo -e "  ${ICON_OK} ${GREEN}$1${RESET}"; }
warn()    { echo -e "  ${ICON_WARN} ${YELLOW}$1${RESET}"; }
fail()    { echo -e "  ${ICON_FAIL} ${RED}$1${RESET}"; }

# ──────────────────────────────── Global State ────────────────────────────────

INSTALL_DIR=""
TINYTEX_INSTALLER=""
BIN_PATH=""
RC_FILE=""

# ──────────────────────────────── Step Functions ────────────────────────────────

step1_check_deps() {
    step 1 "Checking system dependencies"

    local missing=()

    if command -v perl &>/dev/null && perl -mFile::Find -e '' 2>/dev/null; then
        ok "perl  installed  ${DIM}($(perl -v 2>/dev/null | grep -oP 'v\d+\.\d+\.\d+' | head -1))${RESET}"
    else
        fail "perl  not found"
        missing+=("perl")
    fi

    if command -v xz &>/dev/null; then
        ok "xz    installed  ${DIM}($(xz --version 2>/dev/null | head -1))${RESET}"
    else
        fail "xz    not found"
        missing+=("xz")
    fi

    if command -v curl &>/dev/null; then
        ok "curl  installed"
    else
        fail "curl  not found"
        missing+=("curl")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        echo ""
        warn "Missing dependencies detected:"
        for dep in "${missing[@]}"; do
            echo -e "    ${RED}•${RESET} ${WHITE}${dep}${RESET}"
        done
        echo ""
        echo -e "  ${DIM}Ubuntu/Debian:${RESET}  ${CYAN}sudo apt install -y ${missing[*]}${RESET}"
        echo -e "  ${DIM}CentOS/RHEL:${RESET}    ${CYAN}sudo yum install -y ${missing[*]}${RESET}"
        echo -e "  ${DIM}macOS:${RESET}          ${CYAN}brew install ${missing[*]}${RESET}"
        echo ""
        exit 1
    fi

    ok "All dependencies are ready"
}

step2_install_tinytex() {
    step 2 "Downloading and installing TinyTeX"

    info "Fetching from tinytex.yihui.org ..."
    echo ""

    export TINYTEX_INSTALLER
    export TINYTEX_DIR="${INSTALL_DIR}"

    if curl -sL "https://tinytex.yihui.org/install-bin-unix.sh" | sh; then
        ok "TinyTeX installed successfully"
    else
        fail "TinyTeX installation failed — check your network connection"
        exit 1
    fi
}

step3_configure_path() {
    step 3 "Configuring PATH"

    local arch
    arch=$(uname -m)
    case "${arch}" in
        x86_64)        BIN_PATH="${INSTALL_DIR}/.TinyTeX/bin/x86_64-linux" ;;
        aarch64|arm64) BIN_PATH="${INSTALL_DIR}/.TinyTeX/bin/aarch64-linux" ;;
        *)             BIN_PATH="${INSTALL_DIR}/.TinyTeX/bin/x86_64-linux" ;;
    esac

    info "Architecture: ${CYAN}${arch}${RESET}"
    info "Bin path:     ${CYAN}${BIN_PATH}${RESET}"

    local shell_name
    shell_name=$(basename "${SHELL:-bash}")
    case "${shell_name}" in
        zsh)  RC_FILE="${HOME}/.zshrc" ;;
        bash) RC_FILE="${HOME}/.bashrc" ;;
        *)    RC_FILE="${HOME}/.profile" ;;
    esac

    info "Shell config: ${CYAN}${RC_FILE}${RESET}"

    local path_line="export PATH=\"${BIN_PATH}:\$PATH\""
    if [ -f "${RC_FILE}" ] && grep -qF "${BIN_PATH}" "${RC_FILE}"; then
        ok "PATH already exists in ${RC_FILE}, skipping"
    else
        echo "" >> "${RC_FILE}"
        echo "# TinyTeX — added by PaperFlow install.sh" >> "${RC_FILE}"
        echo "${path_line}" >> "${RC_FILE}"
        ok "PATH written to ${CYAN}${RC_FILE}${RESET}"
    fi

    export PATH="${BIN_PATH}:${PATH}"
    ok "Current session PATH updated"
}

step4_verify() {
    step 4 "Verifying installation"

    local tools=("pdflatex" "bibtex" "xelatex" "lualatex" "tlmgr")
    local all_ok=true

    for tool in "${tools[@]}"; do
        if command -v "${tool}" &>/dev/null; then
            local version
            version=$("${tool}" --version 2>/dev/null | head -1 || echo "unknown")
            ok "${CYAN}${tool}${RESET}  ${DIM}${version}${RESET}"
        else
            warn "${tool} not found (package may not be installed yet)"
            all_ok=false
        fi
    done

    if [ "${all_ok}" = true ]; then
        echo ""
        ok "All tools verified"
    fi
}

step5_done() {
    step 5 "Installation complete"

    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}║${RESET}                                                          ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}   ${ICON_ROCKET} ${BOLD}${WHITE}PaperFlow TinyTeX installed successfully!${RESET}            ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}                                                          ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}   ${DIM}Run the following to activate PATH:${RESET}                    ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}                                                          ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}     ${CYAN}source ${RC_FILE}${RESET}                                 ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}                                                          ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}   ${DIM}Or simply open a new terminal.${RESET}                         ${GREEN}║${RESET}"
    echo -e "${GREEN}║${RESET}                                                          ${GREEN}║${RESET}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

# ──────────────────────────────── Main ────────────────────────────────

main() {
    INSTALL_DIR="${1:-$HOME/.TinyTeX}"
    TINYTEX_INSTALLER="${2:-TinyTeX-1}"

    banner

    echo -e "${ICON_INFO} ${DIM}Install dir:${RESET}  ${CYAN}${INSTALL_DIR}${RESET}"
    echo -e "${ICON_INFO} ${DIM}Installer:${RESET}    ${CYAN}${TINYTEX_INSTALLER}${RESET}"
    echo ""

    step1_check_deps
    step2_install_tinytex
    step3_configure_path
    step4_verify
    step5_done
}

main "$@"
