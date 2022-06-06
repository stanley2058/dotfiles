#!/usr/bin/env bash

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

case "$distro" in
    "Arch Linux")
        ./Scripts/install-aur-helper.sh
        sudo pacman -S --noconfirm --needed git base-devel tmux gvim fish zsh fzf starship exa lsd ranger neovim
        if command -v paru &> /dev/null; then 
            paru -S --needed --noconfirm c-lolcat fisher
        elif command -v yay &> /dev/null; then
            yay -S --needed --noconfirm c-lolcat fisher
        fi
        ;;
    "Manjaro")
        ./Scripts/install-aur-helper.sh 
        sudo pacman -S --noconfirm --needed git base-devel tmux gvim fish zsh fzf starship exa lsd ranger neovim
        if command -v paru &> /dev/null; then 
            paru -S --needed --noconfirm c-lolcat fisher
        elif command -v yay &> /dev/null; then
            yay -S --needed --noconfirm c-lolcat fisher
        fi
        ;;
    "Ubuntu")
        ;;
    "Debian")
        ;;
    "Fedora Linux")
        sudo dnf install tmux gvim fish zsh fzf starship exa lsd ranger neovim lolcat
        ;;
esac

