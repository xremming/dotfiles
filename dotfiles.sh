#!/bin/bash

set -vxeo pipefail

pacman -S --noconfirm --needed \
    bash-completion \
    fzf \
    ripgrep \
    wget \
    curl \
    github-cli \
    youtube-dl \
    atool \
        bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip \
    imagemagick \
    ffmpeg \
    shellcheck \
    python \
    python-pip \
    pyenv \
    ruby \
    racket \
    go \
    rustup \
    nano \
    npm \
    yarn \
    pandoc \
    jq \
    kakoune

# rustup
rustup update

BACKUP_DIR="$DOTFILES/backup-$(date -Iminutes)"
mkdir "$BACKUP_DIR"

# awscli 2
(
    cd "$BACKUP_DIR"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --update
)

# backup files just in case
for file in ~/.bashrc ~/.bashrc.d ~/.bash_profile ~/.profile ~/.gitconfig ~/.gitconfig-work; do
    if [ -f "$file" ]; then
        mv -f "$file" "$BACKUP_DIR"
    fi
done

# bashrc
cp -f "$DOTFILES"/bashrc ~/.bashrc
mkdir -p ~/.bashrc.d/
cp "$DOTFILES"/bashrc.d/* ~/.bashrc.d/

# profile
cp -f "$DOTFILES"/profile ~/.profile

# gitconfig
cp "$DOTFILES"/gitconfig ~/.gitconfig
cp "$DOTFILES"/gitconfig-work ~/.gitconfig-work
