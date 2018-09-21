#!/bin/bash

# Inspired by https://github.com/JarrodCTaylor/dotfiles/blob/master/install-scripts/OSX/create-symlinks.sh

export DOTFILES=~/git/dotfiles

# Remove old dot files
rm -rf ~/.vim > /dev/null 2>&1
rm -rf ~/.vimrc > /dev/null 2>&1
rm -rf ~/.bashrc > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
mkdir -p ~/.config
#ln -sf ~/dotfiles/vim ~/.vim
ln -sf $DOTFILES/vim/vimrc ~/.vimrc
#ln -sf ~/dotfiles/bashrc ~/.bashrc
#ln -sf ~/dotfiles/mac-tmux ~/.tmux
ln -s $DOTFILES/st3/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
ln -sf $DOTFILES/fish ~/.config/fish
#ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
#ln -sf ~/dotfiles/config ~/.config
#ln -sf ~/dotfiles/custom-configs/custom-snips ~/.vim/custom-snips

# Set fish as the default shell
# add /usr/local/bin/fish to /etc/shells
#chsh -s /bin/usr/local/bin/fish
# Only once it is installed!

