#!/bin/bash

# global bashrc
[ -f /etc/bashrc ] && . /etc/bashrc

# my ssh-agent starter script thing
[ -f ~/.ssh/start-agent ] && . ~/.ssh/start-agent

# autocompletions
complete -C 'aws_completer' aws
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
#eval "$(env _PIPENV_COMPLETE=source-bash pipenv)"
eval "$(env _SCRYCLI_COMPLETE=source-bash scrycli)"

# fzf keybindings
if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
    . /usr/share/fzf/shell/key-bindings.bash
fi

for file in ~/.bashrc.d/*; do
    . "$file"
done
