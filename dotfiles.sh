#!/bin/bash

set -euo pipefail

DOTFILES=$(dirname $(realpath $0))

./update.sh

# backup files just in case
for file in ~/.bashrc ~/.bashrc.d ~/.bash_profile ~/.profile ~/.gitconfig ~/.gitconfig-work; do
    # is either a file or a symlink
    if [ -e "$file" ]; then
        if [ -L "$file" ]; then
            # is a symlink
            rm -f "$file"
        else
            # is a normal file
            mv -f "$file" "$BACKUP_DIR"
        fi
   fi
done

# bashrc and bash_profile
ln -s "$DOTFILES"/bash_profile ~/.bash_profile
ln -s "$DOTFILES"/bashrc ~/.bashrc
mkdir -p ~/.bashrc.d/
ln -s "$DOTFILES"/bashrc.d/* ~/.bashrc.d/

# profile
ln -s "$DOTFILES"/profile ~/.profile

# gitconfig
ln -s "$DOTFILES"/gitconfig ~/.gitconfig
ln -s "$DOTFILES"/gitconfig-work ~/.gitconfig-work

mkdir -p ~/.config

# nvim
ln -s "$DOTFILES"/nvim/ ~/.config
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
