#!/bin/bash

set -xeuo pipefail

pacman -Syu --needed \
    bash-completion \
    fzf \
    ripgrep \
    openssh \
    rsync \
        wget \
        curl \
    tree \
    github-cli \
    youtube-dl \
    atool \
        bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip \
    imagemagick \
    ffmpeg \
    shellcheck \
    python \
    	ipython \
        python-pip \
        python-poetry \
        python-pipenv \
        pyenv \
    ruby \
    racket \
    go \
    rustup \
    nano \
    nodejs \
        npm \
        yarn \
    pandoc \
    jq \
    kakoune \
    dnsutils \
        whois \
        traceroute \
    base-devel \
        gcc \
        clang \
        ninja

# rustup
rustup install stable

# install tools from cargo
cargo install git-delta xsv

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
    # is either a file or a symlink
    if [ -e "$file" ]; then
        # is a symlink
        if [ -L "$file" ]; then
            continue
        fi

        mv -f "$file" "$BACKUP_DIR"
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
