#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/ ~/notes/ ~/Documents/GitHub/ ~/Documents/code/ ~/Documents/code/courses/ ~/Documents/code/fun/ ~/Documents/code/pg/ ~/Documents/classes/ -mindepth 1 -maxdepth 1 -type d | \
        sed "s|^$HOME/||" | \
        sk --margin 10%
    )
    if [[ -n $selected ]]; then
        selected="$HOME/$selected"
    fi
fi

if [[ -z $selected ]]; then
    exit 1
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -n $TMUX ]]; then
    tmux switch-client -t $selected_name
else
    tmux attach-session -t $selected_name
fi
