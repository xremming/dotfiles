#!/bin/bash

set -euo pipefail

pacman -S --needed rustup
rustup install stable
rustup default stable
