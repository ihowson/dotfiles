#!/bin/bash

# Inspired by https://github.com/JarrodCTaylor/dotfiles/blob/master/install-scripts/OSX/create-symlinks.sh

export DOTFILES=~/Sync/dotfiles

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
ln -s $DOTFILES/st2/User ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/
ln -sf $DOTFILES/fish ~/.config/fish
ln -sf $DOTFILES/kitty ~/.config/kitty
ln -sf $DOTFILES/wtf ~/.config/wtf
ln -sf $DOTFILES/hammerspoon ~/.hammerspoon
ln -sf $DOTFILES/atom ~/.atom
mkdir -p ~/.ssh
ln -sf $DOTFILES/ssh/config ~/.ssh/config
ln -sf $DOTFILES/freshclam.conf /usr/local/etc/clamav
ln -sf $DOTFILES/oh-my-tmux/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES/oh-my-tmux/tmux.conf.local ~/.tmux.conf.local
ln -sf $DOTFILES/xbar/ ~/Library/Application\ Support/xbar/plugins
ln -sf $DOTFILES/espanso/ ~/Library/Application\ Support/espanso

mkdir -p ~/.kube
ln -sf ~/dot-ssh/kube/config ./.kube/config

# Set fish as the default shell
# add /usr/local/bin/fish to /etc/shells
#chsh -s /bin/usr/local/bin/fish
# Only once it is installed!

