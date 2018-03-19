#!/bin/bash

# Source: https://github.com/nicksp/dotfiles/blob/master/osx/set-defaults.sh
# 
# Reasonably sets OS X defaults. Sources:
#  - https://github.com/skwp/dotfiles/blob/master/bin/osx
#  - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# ~/dotfiles/osx/set-defaults.sh — http://mths.be/osx
#

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Swipe controls for Google Chrome
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE

# Save screenshots to desktop and disable the horrific drop-shadow.
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Screen
###############################################################################

# Disable and kill Dashboard (old-school screen to the left)
# Can be reverted with:
# defaults write com.apple.dashboard mcx-disabled -boolean NO; killall Doc
defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock

# Disable icons on the Desktop
# This will "hide" all the files on the Desktop, but one can still access
# the files through Finder. Makes things look pretty.
defaults write com.apple.finder CreateDesktop -bool false && killall Finder

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

###############################################################################
# Finder
###############################################################################

# Always open everything in Finder's column view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Allow text-selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

###############################################################################
# SSD
###############################################################################

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

