#!/usr/bin/env bash

sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.bashrc

if [[ -f "$HOME/.zshrc" ]]; then
    sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.zshrc
else
    cp "$HOME/.zshrc.sample" "$HOME/.zshrc"
fi
