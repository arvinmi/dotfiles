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
# Functions & Completions
# ==============================================================================

# tmux new and attach
tmn() {
  tmux new-session -s "$1"
}

tma() {
  tmux attach -t "$1"
}

_tma_complete() {
    local -a sessions
    sessions=(${(f)"$(tmux list-sessions -F '#S' 2>/dev/null)"})
    _describe 'tmux sessions' sessions
}
compdef _tma_complete tma

rst() {
  cd
  clear
}

prof() {
  if [[ -z "$1" ]]; then
    echo "Usage: prof <directory>"
    return 1
  fi
  du -sh "$1"/* | sort -hr
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

gdrive() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: gdrive <google-file-id> <output-path>"
    return 1
  fi
  gdown "https://drive.google.com/uc?id=$1" -O "$2"
}

topc() {
  if [[ -z "$1" ]]; then
    echo "Usage: topc <regex>"
    return 1
  fi
  top -c | grep -E --color=auto "$1"
}

# conda cenv
cenv() {
  conda activate "$1"
}

_cenv_complete() {
  local -a envs
  if [[ -f ~/.conda/environments.txt ]]; then
    envs=(${(f)"$(< ~/.conda/environments.txt)"})
    envs=(${envs##*/})
    _describe 'conda environments' envs
  fi
}
compdef _cenv_complete cenv

# temp script
export TMP_SCRIPT_ROOT="${TMP_SCRIPT_ROOT:-$HOME/.tmp-scripts}"
mkdir -p "$TMP_SCRIPT_ROOT"

tinit() {
  local file="$TMP_SCRIPT_ROOT/$1"
  echo "#!/bin/bash" > "$file"
  chmod +x "$file"
  "${EDITOR:-nvim}" "$file"
}

tedit() {
  "${EDITOR:-nvim}" "$TMP_SCRIPT_ROOT/$1"
}

trun() {
  bash "$TMP_SCRIPT_ROOT/$1"
}

tdelete() {
  rm -i "$TMP_SCRIPT_ROOT/$1"
}

_tscript_complete() {
  local -a scripts
  scripts=(${(f)"$(find "$TMP_SCRIPT_ROOT" -type f -printf '%f\n' 2>/dev/null)"})
  _describe 'tmp-scripts' scripts
}
compdef _tscript_complete tedit
compdef _tscript_complete trun
compdef _tscript_complete tdelete

# make
brun() {
  local file="$1"
  shift

  local name="${file%.*}"
  local ext="${file##*.}"
  local bin="./$name"

  case "$ext" in
    c)
      cc "$file" -o "$bin" || return 1
      ;;
    cpp|cc|cxx)
      c++ "$file" -o "$bin" || return 1
      ;;
    cu)
      nvcc "$file" -o "$bin" || return 1
      ;;
    *)
      echo "Unsupported file type: $ext"
      return 1
      ;;
  esac

  "$bin" "$@"
}

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
alias smi='watch -n 1 nvidia-smi'
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
