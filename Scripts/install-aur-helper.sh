#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed git base-devel

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
    rm -rf yay-bin
fi

if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si
    cd ..
    rm -rf paru-bin
fi
