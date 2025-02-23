#!/bin/bash

# Backup Obsidian from iCloud to local directory
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes" "${HOME}/Documents/Obsidian"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Default/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-0"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 1/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-1"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 2/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-2"
