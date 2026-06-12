#!/usr/bin/env bash
# Enable extrepo-managed third-party repos and install their packages.
# Idempotent; re-runs are safe. Edit the APPS array to customize.

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Don't run this as root, it will sudo where needed." >&2
  exit 1
fi

log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

command -v extrepo >/dev/null 2>&1 || { sudo apt update && sudo apt install -y extrepo; }

# extrepo_name|apt_package_name (the two sometimes diverge)
APPS=(
  "mise|mise"
  "uv|uv"
  "github-cli|gh"
)

log "Enabling extrepo repos"
for entry in "${APPS[@]}"; do
  IFS='|' read -r repo _ <<<"$entry"
  if extrepo search "$repo" 2>/dev/null | grep -q "^Found ${repo}:"; then
    sudo extrepo enable "$repo"
  else
    warn "extrepo '$repo' not found, skipping"
  fi
done

log "Installing packages"
sudo apt update
for entry in "${APPS[@]}"; do
  IFS='|' read -r _ pkg <<<"$entry"
  dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt install -y "$pkg" || warn "install failed for '$pkg'"
done

log "Done."
