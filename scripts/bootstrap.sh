#!/usr/bin/env bash
# Apt baseline for a fresh Ubuntu install. Idempotent; re-runs are safe.
# Follow with ./install-extrepo.sh, then ../install.sh.

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Don't run this as root, it will sudo where needed." >&2
  exit 1
fi

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }

log "Updating package index and installing packages"
sudo apt update && sudo apt install -y \
  git \
  git-lfs \
  curl \
  tree \
  p7zip-full \
  qemu-kvm \
  libvirt-daemon-system \
  libvirt-clients \
  virtinst \
  bridge-utils \
  virt-manager \
  mpv \
  libreoffice \
  extrepo

log "Cleaning up"
sudo apt autoremove -y --purge && sudo apt autoclean

log "Done."
