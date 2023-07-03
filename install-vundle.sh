#!/usr/bin/env bash

git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall
