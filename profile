export SHELL="/bin/bash"
export TERMINAL="alacritty"
export EDITOR="micro"
export PAGER="less"
export BROWSER="google-chrome"

# less options
export LESS="-r"

# private bins
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

# fzf
export FZF_DEFAULT_OPTS="--preview='if [ -f {} ]; then head -100 {}; elif [ -d {} ]; then ls -a {}; fi' --height='50%'"

# linuxbrew
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

export PATH
export MANPATH
export INFOPATH
