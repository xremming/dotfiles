export SHELL="/bin/bash"
export EDITOR="vim"
export PAGER="less"

# --- GENERAL CONFIGURATION ---

# less options
export LESS="-r"

# fzf
export FZF_DEFAULT_OPTS="--preview='if [ -f {} ]; then head -100 {}; elif [ -d {} ]; then ls -a {}; fi' --height='50%'"

# --- PATH CHANGES ---

# private bins
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

export PATH
