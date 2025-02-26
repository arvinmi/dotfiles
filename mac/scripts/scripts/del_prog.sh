#!/bin/bash

# prompt user for search keyword
read -rp "Enter search keyword: " KEYWORDS

# check if at least one keyword is entered
if [[ -z "$KEYWORDS" ]]; then
    echo "No keywords entered. Exiting."
    exit 1
fi

# convert space-separated keywords into a grep pattern (e.g., "Discord|discord")
# TODO: not fully functional
GREP_PATTERN=$(echo "$KEYWORDS" | sed 's/ /\\|/g')

# define excluded dirs (to speed up search)
EXCLUDE_DIRS="proc|sys|dev|run|Volumes|Network|cores"

# search for dirs matching the keywords (excluding system dirs above)
echo "Searching for directories containing: $KEYWORDS..."
MATCHES=$(sudo find / -mount -type d 2>/dev/null | grep -iE "$GREP_PATTERN" | grep -vE "$EXCLUDE_DIRS" | sort -u)

# if no matches are found, exit
if [[ -z "$MATCHES" ]]; then
    echo "No matching directories found."
    exit 0
fi

# if dirs found, isplay matching dirs with colored highlighting
echo "Matching directories (highlighted):"
echo "$MATCHES" | grep -iE --color=always "$GREP_PATTERN"

