#!/usr/bin/env bash
# Wire the dotfiles into $HOME. Idempotent; prompts before touching
# any existing file.

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Don't run this as root, install into your own \$HOME." >&2
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

confirm() {
  local reply
  read -r -p "$1 [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

link_file() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$src" ]]; then
    log "Already linked: $dst"
    return 0
  fi
  if [[ -e "$dst" ]]; then
    if confirm "$dst exists, back it up to ${dst}.bak and replace?"; then
      mv "$dst" "${dst}.bak"
    else
      warn "Skipping $dst"
      return 0
    fi
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  log "Linked: $dst -> $src"
}

BASHRC_LINE="[ -f \"$DOTFILES_DIR/bash/bashrc\" ] && . \"$DOTFILES_DIR/bash/bashrc\""
if grep -qF "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc" 2>/dev/null; then
  log "Already sourced from ~/.bashrc"
else
  log "Adding source line to ~/.bashrc"
  printf '\n# dotfiles additions\n%s\n' "$BASHRC_LINE" >>"$HOME/.bashrc"
fi

link_file "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"

if [[ ! -f "$HOME/.gitconfig-personal" ]]; then
  cp "$DOTFILES_DIR/git/gitconfig-personal.example" "$HOME/.gitconfig-personal"
  warn "Created ~/.gitconfig-personal from the example, edit it with your identity."
fi

log "Done. Open a new shell to pick up the bash changes."
