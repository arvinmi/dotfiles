#!/bin/zsh
# This first shell script will help to link dotfiles

# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git

# For rebuilding dotfiles
# cd dotfiles/mac0.sh
# sh mac0.sh

# Close System Settings panes, to prevent them from overriding
osascript -e "tell application 'System Preferences' to quit"

# Ask for administrator password upfront
sudo -v

# Keep Alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Clone dotfiles
mkdir "${HOME}/Documents/config"
git clone https://github.com/arvinmi/dotfiles.git "${HOME}/Documents/config/dotfiles"

# Remove old dotfiles
rm -r -f "${HOME}/.zshrc"
rm -r -f "${HOME}/.zprofile"
rm -r -f "${HOME}/.p10k.zsh"
rm -r -f "${HOME}/.vimrc"
rm -r -f "${HOME}/.tmux.conf"
rm -r -f "${HOME}/scripts"
rm -r -f "${HOME}/.config/nvim"
rm -r -f "${HOME}/.skhdrc"
rm -r -f "${HOME}/dotfiles"
rm -r -f "${HOME}/.config/nvim"
rm -r -f "${HOME}/Library/Application Support/Code/User/settings.json"
rm -r -f "${HOME}/Library/Application Support/Code/User/snippets/"
# rm -r -f "${HOME}/.gitconfig"

# Create symlinks for new directories
mkdir "${HOME}/Documents/backup"
mkdir "${HOME}/Documents/code"
mkdir "${HOME}/Documents/code/build"
mkdir "${HOME}/Documents/code/fun"
mkdir "${HOME}/Documents/code/test"
mkdir "${HOME}/Documents/personal"
mkdir "${HOME}/Documents/vault"
mkdir "${HOME}/virtual-machines"
mkdir "${HOME}/virtual-machines/ubuntu"
mkdir "${HOME}/virtual-machines" && mkdir "${HOME}/virtual-machines/buildroot-images"
mkdir "${HOME}/Library/Application Support/Code/User/snippets"
mkdir "${HOME}/Documents/Obsidian"

ln -s "${HOME}/Documents/backup" "${HOME}/backup"
ln -s "${HOME}/Documents/code" "${HOME}/code"
ln -s "${HOME}/Documents/code/osu" "${HOME}/osu"
ln -s "${HOME}/Documents/code/build" "${HOME}/build"
ln -s "${HOME}/Documents/code/fun" "${HOME}/fun"
ln -s "${HOME}/Documents/config/dotfiles" "${HOME}/dotfiles"
ln -s "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/" "${HOME}/notes"
ln -s "${HOME}/Library/CloudStorage/" "${HOME}/drive"

# Create symlinks for new dotfiles
ln -s "${HOME}/Documents/config/dotfiles/zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/Documents/config/dotfiles/zprofile" "${HOME}/.zprofile"
ln -s "${HOME}/Documents/config/dotfiles/vimrc" "${HOME}/.vimrc"
ln -s "${HOME}/Documents/config/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
ln -s "${HOME}/Documents/config/dotfiles/config/skhd/skhdrc" "${HOME}/.skhdrc"
ln -s "${HOME}/Documents/config/dotfiles/scripts" "${HOME}/scripts"
ln -s "${HOME}/Documents/config/dotfiles/config/nvim" "${HOME}/.config/nvim"
ln -s "${HOME}/Documents/config/dotfiles/config/brew/Brewfile" "${HOME}/Brewfile"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/settings.json" "${HOME}/Library/Application Support/Code/User/"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/snips.code-snippets" "${HOME}/Library/Application Support/Code/User/snippets/"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/keybindings.json" "${HOME}/Library/Application Support/Code/User/keybindings.json"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/settings.json" "${HOME}/Library/Application Support/Cursor/User/"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/snips.code-snippets" "${HOME}/Library/Application Support/Cursor/User/snippets"
ln -s "${HOME}/Documents/config/dotfiles/config/vscode/keybindings.json" "${HOME}/Library/Application Support/Cursor/User/keybindings.json"
cp "${HOME}/Documents/config/dotfiles/scripts/launchd/backups.plist" "${HOME}/Library/LaunchAgents/"
cp "${HOME}/Documents/config/dotfiles/scripts/launchd/backup-local.plist" "${HOME}/Library/LaunchAgents/"
# ln -s "${HOME}/Documents/config/dotfiles/viminfo" "${HOME}/.viminfo"
# ln -s "${HOME}/Documents/config/dotfiles/.gitconfig" "${HOME}/.gitconfig"
