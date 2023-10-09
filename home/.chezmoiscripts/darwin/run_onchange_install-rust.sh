#!/bin/bash

set -euo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup install stable
rustup default stable
