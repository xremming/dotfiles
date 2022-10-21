#!/bin/bash

set -e
set -o pipefail

pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm --needed git

cd ~

if [ -d .dotfiles ]; then
    (cd .dotfiles; git pull;)
else
    git clone https://github.com/xremming/dotfiles.git .dotfiles
fi
(cd .dotfiles; git remote set-url origin git@github.com:xremming/dotfiles.git;)

. "$DOTFILES/dotfiles.sh"
