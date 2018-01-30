#!/bin/bash

set -e
set -o pipefail

function rpm_url_install() {
    curl "$1" -Lo "$2.rpm"
    sudo dnf install -y "./$2.rpm"
}

sudo dnf upgrade -y
sudo dnf install -y git

cd ~
rm -rf .dotfiles
git clone https://github.com/PolarPayne/dotfiles.git .dotfiles
DOTFILES="$(pwd)/.dotfiles"

# install basic utilities and such
sudo dnf install -y \
    curl \
    wget \
    atool \
    snapd \
    cloc \
    ripgrep \
    fzf \
    micro \
    meld

# create my usual directories
mkdir -p work programming

# --- SPOTIFY ---
sudo snap install spotify

# goto a temp directory since we'll download stuff
# also use a subshell so we don't need to cd out
(
    cd "$(mktemp -d)"

    # --- GOOGLE-CHROME ---
    [ -z "$GOOGLE_CHROME_URL" ] && GOOGLE_CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    rpm_url_install "$GOOGLE_CHROME_URL" google-chrome

    # --- DROPBOX ---
    [ -z "$DROPBOX_URL" ] && DROPBOX_URL="https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2015.10.28-1.fedora.x86_64.rpm"
    rpm_url_install "$DROPBOX_URL" dropbox

    # used by dropbox start -i
    sudo dnf install -y python2-pygpgme
    dropbox start -i

    # --- SLACK ---
    [ -z "$SLACK_URL" ] && SLACK_URL="https://downloads.slack-edge.com/linux_releases/slack-3.0.5-0.1.fc21.x86_64.rpm"
    rpm_url_install "$SLACK_URL" slack.rpm
)

# --- FIRA CODE FONT ---
mkdir -p ~/.local/share/fonts/
for type in Bold Light Medium Regular Retina; do
    curl -o ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
done
fc-cache -f

# --- VSCODE ---
# from https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << EOF | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
dnf check-update
sudo dnf install code

# install extensions
# @cleanup these are probably not all needed
code --install-extension \
    2gua.rainbow-brackets \
    anseki.vscode-color \
    bibhasdn.unique-lines \
    codezombiech.gitignore \
    eamodio.gitlens \
    EditorConfig.EditorConfig \
    felipecaputo.git-project-manager \
    formulahendry.code-runner \
    hackwaly.ocaml \
    itryapitsin.Scala \
    lukehoban.Go \
    magicstack.MagicPython \
    mathiasfrohlich.Kotlin \
    mattn.Lisp \
    mauve.terraform \
    ms-python.python \
    ms-vscode.cpptools \
    naereen.makefiles-support-for-vscode \
    nopjmp.fairyfloss \
    octref.vetur \
    PeterJausovec.vscode-docker \
    PKief.material-icon-theme \
    slevesque.vscode-hexdump \
    timonwong.shellcheck \
    vscodevim.vim \
    wholroyd.jinja \
    yzhang.markdown-all-in-one \
    zhuangtongfa.Material-theme

# install global settings
mkdir -p ~/.config/Code/User
cp "$DOTFILES/vscode-settings.json" ~/.config/Code/User/settings.json

# --- PIA ---
# download, unpack, run
# TODO

# --- OTHER STUFF ---
# install linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

brew install mpv

# --- PYENV ---
rm -rf ~/.pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# --- DOTFILES ---
mkdir -p ~/.ssh/
cp "$DOTFILES/start-agent" ~/.ssh/

cp "$DOTFILES/bashrc" ~/.bashrc
rm -rf ~/.bashrc.d/
mkdir -p ~/.bashrc.d/
cp "$DOTFILES/bashrc.d/*" ~/.bashrc.d/

cp "$DOTFILES/profile" ~/.profile

# TODO install my own binaries to ~/bin
# TODO install pipenv, docker, docker-compose, yed, alacritty?
# TODO install configurations (i3? what else?)
