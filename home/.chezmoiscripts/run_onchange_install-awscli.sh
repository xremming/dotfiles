#!/bin/bash

set -euo pipefail

cd "$(mktemp -d)" || exit 1
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install --update
