#!/bin/bash

set -euo pipefail

pacman -S --noconfirm --needed rustup
rustup install stable
rustup default stable
