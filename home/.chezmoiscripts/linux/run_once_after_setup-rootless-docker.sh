#!/bin/bash

set -euo pipefail

# Rootless Docker refuses to install while the system daemon owns
# /var/run/docker.sock, and running both would split images between them.
sudo systemctl disable --now docker.socket docker.service

# The setup tool writes the user unit itself, so its presence means a
# previous run already finished.
if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/docker.service" ]]; then
  dockerd-rootless-setuptool.sh install
fi
