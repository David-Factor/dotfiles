#!/bin/sh

NEOVIM_CONFIG_PATH="$HOME/.config/nvim/"

# symlink init.vim to 
mkdir -p "$NEOVIM_CONFIG_PATH"
ln -s "$PWD/init.vim" "$NEOVIM_CONFIG_PATH" 

# Install vim-plug for neovim 
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install plugins
nvim +PlugInstall +qall

