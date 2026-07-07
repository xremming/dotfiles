#!/bin/bash

set -euo pipefail

# Claude Code keeps itself up to date, so only install when missing
if ! [ -x "$HOME/.local/bin/claude" ] && ! command -v claude >/dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
fi
