#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# global bashrc
[ -f /etc/bashrc ] && . /etc/bashrc

# fzf keybindings
if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
    . /usr/share/fzf/shell/key-bindings.bash
fi

# added by travis gem
if [ -f "$HOME/.travis/travis.sh" ]; then
    . "$HOME/.travis/travis.sh"
fi

# --- .bashrd.d ---

for file in ~/.bashrc.d/*; do
    . "$file"
done
