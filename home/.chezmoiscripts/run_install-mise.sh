#!/bin/bash

set -euo pipefail

# mise is installed with its installer script instead of a package manager so
# that self-update works the same way on both Linux and macOS
if [ -x "$HOME/.local/bin/mise" ]; then
    "$HOME/.local/bin/mise" self-update --yes
else
    curl -fsSL https://mise.run | sh
fi
