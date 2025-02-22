#!/bin/bash

# Sync iCloud drive "~/Desktop"
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Desktop/" "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Desktop/"

# Sync iCloud drive "~/Documents"
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Documents/" "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Documents/"

# Backup SYNO "~/Desktop"
/opt/homebrew/bin/rclone sync --exclude=".DS_Store" --links "${HOME}/Desktop/" "syno-remote:Backups/mac/Desktop"

# Backup SYNO "~/Documents"
/opt/homebrew/bin/rclone sync --exclude=".DS_Store" --links "${HOME}/Documents/" "syno-remote:Backups/mac/Documents"

# Backup SYNO "~/Downloads"
# /opt/homebrew/bin/rclone sync --exclude=".DS_Store" --links "${HOME}/Downloads/" "syno-remote:Backups/mac/Downloads"

# Backup SYNO "~/virtual-machines"
/opt/homebrew/bin/rclone sync --exclude=".DS_Store" --links "${HOME}/virtual-machines/" "syno-remote:Backups/mac/virtual-machines"

# Backup Gdrive "~/code"
/opt/homebrew/bin/rclone sync --exclude=".DS_Store" --links "${HOME}/Documents/code" "gdrive-remote:Backups/mac"
