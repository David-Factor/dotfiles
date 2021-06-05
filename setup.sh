#!/bin/sh



## ZSH Setup

# Clean up
rm -r -f "$HOME/.oh-my-zsh/"
cp "$HOME/.zshrc" "$HOME/.zshrc.orig"
rm "$HOME/.zshrc"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Symlink .zshrc
ln -s "$PWD/.zshrc" "$HOME"

# Change default shell to zsh
chsh -s /bin/zsh

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add bre to path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile eval "$(/opt/homebrew/bin/brew shellenv)"


# Install node
brew install node

# Install elm related npm packages
npm install -g elm @elm-tooling/elm-language-server elm-test elm-format elm-analyse

# Install utils
brew install ripgrep
brew install tree

### NEOVIM

brew install neovim

NEOVIM_CONFIG_PATH="$HOME/.config/nvim/"

# Symlink init.vim
mkdir -p "$NEOVIM_CONFIG_PATH"
mv "$NEOVIM_CONFIG_PATH/init.vim" "$NEOVIM_CONFIG_PATH/init.vim.orig"
ln -s "$PWD/init.vim" "$NEOVIM_CONFIG_PATH"

# Symlink coc settings
ln -s "$PWD/coc-settings.json" "$NEOVIM_CONFIG_PATH"

# Install vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install neovim plugins via vim-plug
nvim +PlugClean +PlugInstall +qall


# Install haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Install julia
brew cask install julia

# Install go
brew install go

echo "DONE"
