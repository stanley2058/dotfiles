#!/usr/bin/env bash

cp .alias_profile $HOME
cp .env_profile $HOME
cp .vimrc $HOME
cp -r .config $HOME
cp -r Scripts $HOME
cp -r .tmux $HOME
ln -s -f $HOME/.tmux/.tmux.conf $HOME/.tmux.conf
cp .tmux.conf.local $HOME
