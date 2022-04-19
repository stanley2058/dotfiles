#!/usr/bin/env bash

./Scripts/install-aur-helper.sh

sudo pacman -S --noconfirm --needed git base-devel tmux gvim fish zsh fzf starship exa lsd ranger

if command -v paru &> /dev/null; then 
    paru -S --needed --noconfirm c-lolcat fisher
elif command -v yay &> /dev/null; then
    yay -S --needed --noconfirm c-lolcat fisher
fi
