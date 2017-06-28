#!/bin/bash

# speed up key repeat and decrease initial delay
# https://apple.stackexchange.com/a/83923
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2


# below this line, not reviewed by Ian
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write -g QLPanelAnimationDuration -float 0
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
#defaults write com.apple.finder DisableAllAnimations -bool true
#defaults write com.apple.dock launchanim -bool false
#defaults write com.apple.dock expose-animation-duration -float 0.1
#defaults write com.apple.Dock autohide-delay -float 0
#defaults write NSGlobalDomain KeyRepeat -int 0

