#!/bin/bash

set -euo pipefail

pacman-key --init
pacman-key --populate archlinux
pacman -Sy archlinux-keyring
pacman -Sy unzip wget curl
