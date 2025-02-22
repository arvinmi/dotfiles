#!/bin/bash

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Default/Bookmarks" "${HOME}/Documents/vault/bookmarks/profile-1"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 8/Bookmarks" "${HOME}/Documents/vault/bookmarks/profile-2"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 16/Bookmarks" "${HOME}/Documents/vault/bookmarks/profile-3"

# Backup Chrome bookmarks
rsync -avz --delete-before --exclude=".DS_Store" --exclude=".Trash/" "${HOME}/Library/Application Support/Google/Chrome/Profile 17/Bookmarks" "${HOME}/Documents/vault/bookmarks/profile-4"
