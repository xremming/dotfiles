#!/bin/bash

set -e
set -o pipefail

pacman-key --init
pacman -Syu --noconfirm --needed git

cd ~
if [ -d .dotfiles ]; then
    (cd .dotfiles; git pull;)
else
    git clone https://github.com/PolarPayne/dotfiles.git .dotfiles
fi
(cd .dotfiles; git remote set-url origin git@github.com:PolarPayne/dotfiles.git;)
DOTFILES="$(pwd)/.dotfiles"

. "$DOTFILES/dotfiles.sh"
