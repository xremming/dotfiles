#!/bin/bash

set -euo pipefail

if grep -q /opt/homebrew/bin/bash /etc/shells; then
    echo "/opt/homebrew/bin/bash is already in /etc/shells"
else
    echo "Adding /opt/homebrew/bin/bash to /etc/shells"
    echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells
fi

echo "Changing login shell to /opt/homebrew/bin/bash"
chsh -s /opt/homebrew/bin/bash
