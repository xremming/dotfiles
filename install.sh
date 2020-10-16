#!/bin/bash

set -e
set -o pipefail

pacman -Syu git

cd ~
if [ -d .dotfiles ]; then
    (cd .dotfiles; git pull;)
else
    git clone https://github.com/PolarPayne/dotfiles.git .dotfiles
fi
DOTFILES="$(pwd)/.dotfiles"

. "$DOTFILES/dotfiles.sh"
