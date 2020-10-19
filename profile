export SHELL="/bin/bash"
export EDITOR="kak"
export PAGER="less"

# --- PATH CHANGES ---

# private bins
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

export PATH
