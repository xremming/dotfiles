#!/bin/bash

set -euo pipefail

sudo pacman -S --needed rustup
rustup install stable
rustup default stable
