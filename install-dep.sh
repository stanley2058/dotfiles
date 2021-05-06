#!/usr/bin/env bash

sudo pacman -S --needed git base-devel tmux gvim lolcat fish zsh fzf starship

if command -v yay &> /dev/null; then 
    yay -S --needed fisher
elif command -v paru &> /dev/null; then
    paru -S --needed fisher
fi

