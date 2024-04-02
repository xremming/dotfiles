#!/bin/bash

set -euo pipefail

sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy archlinux-keyring
sudo pacman -Sy unzip wget curl
