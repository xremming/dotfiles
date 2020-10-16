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

if command -v aws &> /dev/null; then
    complete -C 'aws_completer' aws
fi
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi
if command -v gh &> /dev/null; then
    eval "$(gh completion -s bash)"
fi

# added by travis gem
if [ -f "$HOME/.travis/travis.sh" ]; then
    . "$HOME/.travis/travis.sh"
fi

# --- .bashrd.d ---

for file in ~/.bashrc.d/*; do
    . "$file"
done
