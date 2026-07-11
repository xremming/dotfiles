#!/bin/bash

set -euo pipefail

# RPM Fusion provides packages Fedora doesn't ship (media codecs, nvidia drivers, etc.)
if ! rpm -q rpmfusion-free-release &>/dev/null; then
  sudo dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
fi

if ! rpm -q rpmfusion-nonfree-release &>/dev/null; then
  sudo dnf install -y \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi
