cp .alias_profile $HOME
cp .env_profile $HOME
cp .vimrc $HOME
cp -r .config $HOME/.config

sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.bashrc
sed -i -e '$asource $HOME/.alias_profile\nsource $HOME/.env_profile' $HOME/.zshrc

vim +PluginInstall +qall
