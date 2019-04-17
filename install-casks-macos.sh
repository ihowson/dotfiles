#!/bin/bash

export INST='brew cask install'

$INST sublime-text
$INST sublime-merge
$INST dropbox
#$INST 1password  # nope; get 1password6 manually
$INST iterm2
$INST google-chrome
$INST cog
$INST bettertouchtool
$INST dash
$INST sourcetree
$INST beyond-compare
$INST fantastical
$INST gpgtools
$INST teamviewer
$INST firefox
$INST hammerspoon
$INST visual-studio-code
$INST font-mononoki
$INST microsoft-office
$INST istat-menus
$INST vlc
$INST docker
$INST slack
$INST plex-media-player
$INST kode54-cog
$INST cryptomator
$INST homebrew/cask-fonts/font-input
$INST nomachine

# Install SF Mono
cp /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf ~/Library/Fonts/
