#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# global bashrc
[ -f /etc/bashrc ] && . /etc/bashrc

# --- .bashrd.d ---

for file in ~/.bashrc.d/*; do
    . "$file"
done
