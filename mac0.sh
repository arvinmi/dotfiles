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
mkdir "${HOME}/build"
mkdir "${HOME}/Documents/code" && mkdir "${HOME}/Documents/code/pg"
mkdir "${HOME}/Documents/personal"
mkdir "${HOME}/Documents/vault"
mkdir "${HOME}/virtual-machines" && mkdir "${HOME}/virtual-machines/ubuntu" && mkdir "${HOME}/virtual-machines/buildroot-images"
mkdir "${HOME}/Documents/Obsidian"
ln -sv "${HOME}/Documents/code" "${HOME}/code" && ln -s "${HOME}/Documents/classes" "${HOME}/classes"
ln -sv "${HOME}/Documents/GitHub/dotfiles/" "${HOME}/dotfiles"
ln -sv "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/" "${HOME}/notes"
ln -sv "${HOME}/Library/CloudStorage/" "${HOME}/drive"

# Stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# Stow mac files
for file in "brew" "conda" "cursor" "ghostty" "git" "scripts" "skhd" "ssh" "vscode" "zsh" "repomix"; do
  stow --verbose --target="$HOME" --dir="mac" --restow "$file"
done

# Copy keyboard layouts
cp -v "mac/keyboard/Library/Keyboard Layouts/Qworak.keylayout" "$HOME/Library/Keyboard Layouts/"
cp -v "mac/keyboard/Library/Keyboard Layouts/Default.keylayout" "$HOME/Library/Keyboard Layouts/"

# Setup launchd scripts
cp -v "mac/scripts/scripts/launchd/backups.plist" "$HOME/Library/LaunchAgents/com.user.backups.plist"
cp -v "mac/scripts/scripts/launchd/backup-local.plist" "$HOME/Library/LaunchAgents/com.user.backups.local.plist"
chmod +x "${HOME}/dotfiles/mac/scripts/scripts/backups.sh"
chmod +x "${HOME}/dotfiles/mac/scripts/scripts/backup_local.sh"
chmod 644 "${HOME}/Library/LaunchAgents/com.user.backups.plist"
chmod 644 "${HOME}/Library/LaunchAgents/com.user.backups.local.plist"

# Setup sleep block
sudo cp -v "mac/scripts/scripts/launchd/sleep-block.plist" "/Library/LaunchDaemons/com.user.sleepblock.plist"
sudo chmod +x "${HOME}/dotfiles/mac/scripts/scripts/sleep_block.sh"
sudo chmod 644 "/Library/LaunchDaemons/com.user.sleepblock.plist"
# Setup sleep block guard
sudo cp -v "mac/scripts/scripts/launchd/sleep-block-guard.plist" "/Library/LaunchDaemons/com.user.sleepblock.guard.plist"
sudo chmod +x "${HOME}/dotfiles/mac/scripts/scripts/sleep_block_guard.sh"
sudo chmod 644 "/Library/LaunchDaemons/com.user.sleepblock.guard.plist"