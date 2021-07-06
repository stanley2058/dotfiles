#!/usr/bin/env bash

./Scripts/install-aur-helper.sh

sudo pacman -S --noconfirm --needed git base-devel tmux gvim lolcat fish zsh fzf starship exa lsd

if command -v yay &> /dev/null; then 
    yay -S --needed --noconfirm fisher
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm fisher
fi

