#!/bin/bash

RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i '0,/plugins=(git)/s//plugins=(git vi-mode colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)/; 0,/ZSH_THEME=.*/s//ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
zsh -c "source ~/.zshrc; p10k configure; exit"

