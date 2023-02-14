#!/usr/bin/env bash

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

case "$distro" in
    "Arch Linux")
        ./Scripts/install-aur-helper.sh
        sudo pacman -S --noconfirm --needed git base-devel tmux gvim fish zsh fzf starship exa lsd ranger neovim fd bat
        if command -v paru &> /dev/null; then 
            paru -S --needed --noconfirm c-lolcat fisher
        elif command -v yay &> /dev/null; then
            yay -S --needed --noconfirm c-lolcat fisher
        fi
        ;;
    "Manjaro")
        ./Scripts/install-aur-helper.sh 
        sudo pacman -S --noconfirm --needed git base-devel tmux gvim fish zsh fzf starship exa lsd ranger neovim fd bat
        if command -v paru &> /dev/null; then 
            paru -S --needed --noconfirm c-lolcat fisher
        elif command -v yay &> /dev/null; then
            yay -S --needed --noconfirm c-lolcat fisher
        fi
        ;;
    "Ubuntu")
        sudo apt install zsh fish tmux neovim ranger exa fzf fd-find bat
        sudo snap install lolcat-c starship
        ;;
    "Fedora Linux")
        sudo dnf install tmux gvim fish zsh fzf starship exa lsd ranger neovim lolcat fd-find bat
        ;;
esac


# Install spark
mkdir -p "$HOME/.local/bin"
curl -sL https://raw.githubusercontent.com/holman/spark/master/spark > "$HOME/.local/bin/spark"
chmod +x "$HOME/.local/bin/spark"

