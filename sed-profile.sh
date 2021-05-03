#!/usr/bin/env bash

sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.bashrc
sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.zshrc
