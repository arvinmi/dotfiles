#!/bin/zsh
# This first shell script will help to link dotfiles

# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git

# For building/rebuilding dotfiles
# cd dotfiles
# sh mac0.sh

# Close System Settings panes, to prevent them from overriding
osascript -e "tell application 'System Preferences' to quit"

# Ask for administrator password upfront
sudo -v

# Keep Alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Clone dotfiles
mkdir "${HOME}/Documents/GitHub"
git clone https://github.com/arvinmi/dotfiles.git "${HOME}/Documents/GitHub/dotfiles"

# Create new dirs and symlinks
mkdir "${HOME}/Documents/backup"
mkdir "${HOME}/build"
mkdir "${HOME}/Documents/code" && mkdir "${HOME}/Documents/code/fun" && mkdir "${HOME}/Documents/code/pg"
mkdir "${HOME}/Documents/personal"
mkdir "${HOME}/Documents/vault"
mkdir "${HOME}/virtual-machines" && mkdir "${HOME}/virtual-machines/ubuntu" && mkdir "${HOME}/virtual-machines/buildroot-images"
mkdir "${HOME}/Documents/Obsidian"
ln -sv "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/" "${HOME}/notes"
ln -sv "${HOME}/Library/CloudStorage/" "${HOME}/drive"
ln -sv "${HOME}/Documents/GitHub/dotfiles/" "${HOME}/dotfiles"

# Stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# Stow mac files
for file in "brew" "conda" "cursor" "ghostty" "git" "scripts" "skhd" "ssh" "vscode" "zsh"; do
  stow --verbose --target="$HOME" --dir="mac" --restow "$file"
done

# Copy launchd files
cp -v "mac/scripts/scripts/launchd/backups.plist" "$HOME/Library/LaunchAgents/"
cp -v "mac/scripts/scripts/launchd/backup-local.plist" "$HOME/Library/LaunchAgents/"
