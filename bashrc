#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# global bashrc
[ -f /etc/bashrc ] && . /etc/bashrc

# fzf keybindings
if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
    . /usr/share/fzf/shell/key-bindings.bash
fi

# --- completions ---

complete -C 'aws_completer' aws
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(gh completion -s bash)"

# added by travis gem
[ ! -s "$HOME/.travis/travis.sh" ] || source "$HOME/.travis/travis.sh"

# --- .bashrd.d ---

for file in ~/.bashrc.d/*; do
    . "$file"
done
