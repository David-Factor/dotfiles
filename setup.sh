#!/bin/sh



### ZSH Setup

# Clean up
rm -r -f "$HOME/.oh-my-zsh/"
cp "$HOME/.zshrc" "$HOME/.zshrc.orig"
rm "$HOME/.zshrc"

# Install Oh My Zsh
git clone "https://github.com/robbyrussell/oh-my-zsh.git" "$HOME/.oh-my-zsh"

# Symlink .zshrc 
ln -s "$PWD/.zshrc" "$HOME"

# Change default shell to zsh
chsh -s /bin/zsh 




### NEOVIM

NEOVIM_CONFIG_PATH="$HOME/.config/nvim/"

# Symlink init.vim 
mkdir -p "$NEOVIM_CONFIG_PATH"
ln -s "$PWD/init.vim" "$NEOVIM_CONFIG_PATH" 

# Install vim-plug for neovim 
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install neovim plugins via vim-plug
nvim +PlugInstall +qall



echo "DONE"
