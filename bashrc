#!/bin/bash

# global bashrc
[ -f /etc/bashrc ] && . /etc/bashrc


[ -f ~/.ssh/start-agent ] && . ~/.ssh/start-agent

# bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# autocompletions
complete -C 'aws_completer' aws

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(env _PIPENV_COMPLETE=source-bash pipenv)"
eval "$(env _SCRYCLI_COMPLETE=source-bash scrycli)"


for file in ~/.bashrc.d/*; do
    . "$file"
done

for file in /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*; do
    . "$file"
done
