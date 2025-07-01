# ==============================================================================
# Paths
# ==============================================================================
export EDITOR='vim'

# history
HISTCONTROL=ignoreboth
HISTSIZE=5000000
HISTFILESIZE=5000000

#. "$HOME/.cargo/env"
# export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}

# uv
export PATH="$PATH:/home/kofa/.local/bin"

# miniconda
source ~/miniconda3/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
        export PATH="~/conda/bin:$PATH"
fi

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# isaac-sim
export ISAAC_ROS_WS=/home/kofa/workspaces/isaac_ros-dev/

# nvidia cuda-toolkit (nvcc)
export PATH="/usr/local/cuda-12.8/bin:$PATH"

# cursor
alias cursor="~/Applications/cursor.AppImage --no-sandbox"

# ==============================================================================
# Shell Options
# ==============================================================================
bind '"\e[A": history-search-backward'
bind '"\eOA": history-previous-history'
bind '"\e[B": history-search-forward'
bind '"\eOB": history-next-history'

# ==============================================================================
# Prompt
# ==============================================================================
export PS1="\[\e[1;32m\]\u@\H\[\e[00m\]:\[\e[0;35m\]\w\[\e[00m\]\$ "

export LS_COLORS='di=0;35:ln=1;92:ex=1;92'
# export LSCOLORS=cxgxfxexbxegedabagacad
color_prompt=yes
export TERM=xterm-color
export CLICOLOR=1

# ==============================================================================
# Aliases
# ==============================================================================
# general
alias ls='ls --color'
alias l='ls -ab'
alias la='ls -la'
alias ll='ls -lh'
alias sloc='cloc $(git ls-files)'
alias code='code .'
alias vi='/usr/bin/vim'
alias vim='nvim'
alias newvim='vim $(fzf)'
alias cl='clear'

# git
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gf='git fetch'
alias gpush='git push'
alias gd='git diff'
alias ga='git add .'
alias gc='git checkout'

# rsync
# alias rs='rsync -av --delete'
# alias ssh_known='vim .ssh/known_hosts'

# other
# alias clang++='clang++ -Weverything
alias bb2='conda activate base2'
alias pip='pip3'
alias python='python3'
alias bat='bat'
alias changedisplay='xrandr --output Virtual-1 --mode 1920x1080'
alias nb='jupyter notebook --port=9000 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code'
alias lab='jupyter lab --port=9000 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code'
# alias startremote='systemctl --user start gnome-remote-desktop'
# alias stopremote='systemctl --user stop gnome-remote-desktop'
# alias backupshared='aws s3 sync my_directory s3://mlstorage/downloads'
# alias backuphome="aws s3 sync /home/ubuntu/ s3://backup/raven-dev-home --exclude '.*' --exclude 'miniconda3/*' --exclude 'sky_logs/*' --exclude 'shared/*'"
