#!/bin/bash

set -e
set -o pipefail

function rpm_url_install() {
    curl "$1" -Lo "$2.rpm"
    sudo dnf install -y "./$2.rpm"
}

# rpm fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# everything that we can install with dnf
sudo dnf install -y \
    curl \
    wget \
    atool \
    snapd \
    cloc \
    ripgrep \
    fzf \
    micro \
    meld \
    mpv \
    youtube-dl \
    ImageMagick \
    gcc \
    clang \
    @development-tools \
    meld \
    dnf-plugins-core \
    bash-completion \
    dropbox


dropbox start -i

# create my usual directories
mkdir -p work programming

# spotify
sudo snap install spotify

# goto a temp directory since we'll download stuff
# also use a subshell so we don't need to cd out
(
    cd "$(mktemp -d)"

    # google-chrome
    [ -z "$GOOGLE_CHROME_URL" ] && GOOGLE_CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    rpm_url_install "$GOOGLE_CHROME_URL" google-chrome

    # slack
    [ -z "$SLACK_URL" ] && SLACK_URL="https://downloads.slack-edge.com/linux_releases/slack-3.0.5-0.1.fc21.x86_64.rpm"
    rpm_url_install "$SLACK_URL" slack.rpm

    # lastpass
    curl -Lo lplinux.tar.bz2 https://lastpass.com/lplinux.tar.bz2
    tar xjvf lplinux.tar.bz2
    ./install_lastpass.sh
)

# fira code font
mkdir -p ~/.local/share/fonts/
for type in Bold Light Medium Regular Retina; do
    curl -Lo ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
done
fc-cache -r

# vscode
# from https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << EOF | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
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
for ext in \
"anseki.vscode-color" \
"bibhasdn.unique-lines" \
"codezombiech.gitignore" \
"eamodio.gitlens" \
"felipecaputo.git-project-manager" \
"mauve.terraform" \
"ms-python.python" \
"naereen.makefiles-support-for-vscode" \
"nopjmp.fairyfloss" \
"PeterJausovec.vscode-docker" \
"PKief.material-icon-theme" \
"slevesque.vscode-hexdump" \
"timonwong.shellcheck" \
"wholroyd.jinja"
do
    code --install-extension $ext
done

# install global settings
mkdir -p ~/.config/Code/User
cp "$DOTFILES/vscode-settings.json" ~/.config/Code/User/settings.json

# TODO private internet access
# download, unpack, run

# linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# pyenv
rm -rf ~/.pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# start-agent
mkdir -p ~/.ssh/
cp "$DOTFILES/start-agent" ~/.ssh/

# bashrc
cp "$DOTFILES/bashrc" ~/.bashrc
rm -rf ~/.bashrc.d/
mkdir -p ~/.bashrc.d/
cp "$DOTFILES"/bashrc.d/* ~/.bashrc.d/

# profile
rm -f ~/.bash_profile
cp "$DOTFILES/profile" ~/.profile

# TODO install my own binaries to ~/bin
# TODO compile sct.c

# docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.18.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose


# TODO install rust and alacritty
# TODO install yed https://www.yworks.com/resources/yed/demo/yEd-3.17.2.zip
# TODO install configurations (i3? what else?)
