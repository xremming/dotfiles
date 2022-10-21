#!/bin/bash

set -euo pipefail


./update.sh

DOTFILES=$(dirname $(realpath $0))

BACKUP_DIR="$DOTFILES/backup-$(date --iso-8601=seconds --utc)"
mkdir -p "$BACKUP_DIR"

# backup files just in case
for file in ~/.bashrc ~/.bashrc.d ~/.bash_profile ~/.profile ~/.gitconfig ~/.gitconfig-work ~/.config/nvim; do
    echo "backup $file"

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

echo "symlink configurations"

# bashrc and bash_profile
ln -s "$DOTFILES"/bash_profile ~/.bash_profile
ln -s "$DOTFILES"/bashrc ~/.bashrc
ln -s "$DOTFILES"/bashrc.d/ ~/.bashrc.d

# profile
ln -s "$DOTFILES"/profile ~/.profile

# gitconfig
ln -s "$DOTFILES"/gitconfig ~/.gitconfig
ln -s "$DOTFILES"/gitconfig-work ~/.gitconfig-work

mkdir -p ~/.config

# nvim
ln -s "$DOTFILES"/nvim/ ~/.config
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
