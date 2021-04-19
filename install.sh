#!/usr/bin/env bash
cp .alias_profile $HOME
cp .env_profile $HOME
cp .vimrc $HOME
cp -r .config $HOME
cp -r Scripts $HOME

sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.bashrc
sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.zshrc

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
