#!/bin/bash

set -xeo pipefail

# install all packages from packages.txt
pacman -Sy - < packages.txt

# install latest stable rust
rustup install stable

# install awscli
(
  cd $(mktemp -d)
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -q awscliv2.zip
  ./aws/install --update
)

