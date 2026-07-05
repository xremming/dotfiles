#!/bin/bash

set -euo pipefail

# needed for `dnf copr` in the package install script
sudo dnf install -y --refresh dnf5-plugins
