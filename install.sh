#!/bin/bash

set -e
set -o pipefail

sudo dnf upgrade -y
sudo dnf install -y git

cd ~
rm -rf .dotfiles
git clone https://github.com/PolarPayne/dotfiles.git .dotfiles
DOTFILES="$(pwd)/.dotfiles"

. "$DOTFILES/dotfiles.sh"
