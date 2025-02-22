#!/bin/bash

# Backup Obsidian from iCloud to local directory
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes" "${HOME}/Documents/Obsidian"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Default/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-1"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 8/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-2"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 16/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-3"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 17/Bookmarks" "${HOME}/Documents/vault/bookmarks/Bookmarks-4"
