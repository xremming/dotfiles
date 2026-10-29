#!/bin/bash

set -euo pipefail

kache="$HOME/.local/share/mise/installs/cargo-kache/latest/bin/kache"

# This runs before .chezmoiremove is applied and before mise drops kache, as
# only kache knows how to stop and unregister the launchd agent or systemd
# unit it runs as.
if [[ -x "$kache" ]]; then
  "$kache" daemon uninstall
fi

if [[ -d "$HOME/.local/share/mise/installs/cargo-kache" ]]; then
  "$HOME/.local/bin/mise" uninstall --all cargo:kache
fi
