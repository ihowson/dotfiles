#!/bin/bash

defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

defaults write -g QLPanelAnimationDuration -float 0

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

defaults write com.apple.finder DisableAllAnimations -bool true

defaults write com.apple.dock launchanim -bool false

defaults write com.apple.dock expose-animation-duration -float 0.1

defaults write com.apple.Dock autohide-delay -float 0

#defaults write NSGlobalDomain KeyRepeat -int 0

