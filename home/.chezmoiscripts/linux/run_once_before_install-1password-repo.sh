#!/bin/bash

set -euo pipefail

# 1Password isn't packaged by Fedora, so it comes from the vendor's own repo.
# The 1password package rewrites this file on install, but it has to exist
# beforehand so dnf can find the package in the first place.
if [[ ! -f /etc/yum.repos.d/1password.repo ]]; then
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  sudo tee /etc/yum.repos.d/1password.repo >/dev/null <<'EOF'
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc
EOF
fi
