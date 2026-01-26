# ==============================================================================
# Paths
# ==============================================================================
export EDITOR='vim'

# snap
export PATH="/snap/bin:$PATH"

# history
HISTCONTROL=ignoreboth
HISTSIZE=5000000
HISTFILESIZE=5000000

#. "$HOME/.cargo/env"
# export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}

# miniconda lazy load
_conda_init() {
  unset -f conda
  if [ -f ~/miniconda3/etc/profile.d/conda.sh ]; then
    source ~/miniconda3/etc/profile.d/conda.sh
  fi
}
conda() { _conda_init; conda "$@"; }

# sdkman lazy load
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# nvm lazy load
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v22.21.0/bin:$PATH"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() { unset -f node; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; node "$@"; }
npm() { unset -f npm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npm "$@"; }
npx() { unset -f npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npx "$@"; }

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# isaac-sim
# export ISAAC_ROS_WS=/home/kofa/workspaces/isaac_ros-dev/

# nvidia cuda-toolkit (nvcc)
export PATH="/usr/local/cuda/bin:$PATH"

# cursor
alias cursor="~/Applications/cursor.AppImage --no-sandbox"

# ==============================================================================
# Shell Options
# ==============================================================================
if [[ $- == *i* ]]; then
  bind '"\e[A": history-search-backward'
  bind '"\eOA": history-previous-history'
  bind '"\e[B": history-search-forward'
  bind '"\eOB": history-next-history'

  bind 'set show-all-if-ambiguous on'
  bind 'TAB:menu-complete'
  bind 'set colored-stats on'
  bind 'set completion-ignore-case on'
  bind '"\e[Z":menu-complete-backward'
fi

# ==============================================================================
# Prompt
# ==============================================================================
_short_pwd() {
  local p="${PWD/#$HOME/\~}"
  awk -F/ '{printf $1; for(i=2;i<NF;i++) printf "/"substr($i,1,1); if(NF>1) printf "/"$NF}' <<<"$p"
}
export PS1='\[\e[1;32m\]\u@\h\[\e[00m\]:\[\e[0;35m\]$(_short_pwd)\[\e[00m\]\$ '

export LS_COLORS='di=0;35:ln=1;92:ex=1;92'
# export LSCOLORS=cxgxfxexbxegedabagacad
color_prompt=yes
export CLICOLOR=1

# ==============================================================================
# Functions & Completions
# ==============================================================================

# tmux new and attach
tmn() {
  if [[ $# = 0 ]]; then
    tmux attach -t default || tmux new -s default
  else
    tmux new -s "$@"
  fi
}

tma() {
  tmux attach -t "$1"
}

_tma_complete() {
  local cur sessions
  cur="${COMP_WORDS[COMP_CWORD]}"
  mapfile -t sessions < <(tmux list-sessions -F '#S' 2>/dev/null)
  COMPREPLY=($(compgen -W "${sessions[*]}" -- "$cur"))
}
complete -F _tma_complete tma

# disk usage
prof() {
  if [[ -z "$1" ]]; then
    echo "Usage: prof <directory>"
    return 1
  fi
  du -sh "$1"/* | sort -hr
}

rmdir() {
  rm -ivrf "$@" | grep -v '\.git/'
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
  _conda_init; conda activate "$1";
}

cnd() { 
  _conda_init; conda deactivate;
}

_cenv_complete() {
  local envs
  if [[ -f ~/.conda/environments.txt ]]; then
    mapfile -t envs < ~/.conda/environments.txt
    envs=("${envs[@]##*/}")
    COMPREPLY=($(compgen -W "${envs[*]}" -- "${COMP_WORDS[COMP_CWORD]}"))
  fi
}
complete -F _cenv_complete cenv

# uv uenv
uvenv() {
  local env_path="$HOME/.virtualenvs/$1"
  if [[ -z "$1" ]]; then
    echo "Usage: uvenv <env-name> (<python-version>)"
    return 1
  fi
  if [[ -d "$env_path" ]]; then
    export UV_PROJECT_ENVIRONMENT="$env_path"
    source "$env_path/bin/activate"
  else
    mkdir -p "$HOME/.virtualenvs"
    local py="${2:-${DEFAULT_PYTHON_VERSION:-python3}}"
    uv venv "$env_path" --python "$py"
    export UV_PROJECT_ENVIRONMENT="$env_path"
    source "$env_path/bin/activate"
  fi
}

uvnd() {
  deactivate
}

uvrm() {
  if [[ "$#" -ne "1" ]]; then
    echo "Usage: uvrm <name>"
    return
  fi
  rm -rf ${HOME}/.virtualenvs/$1
  echo "Removed environment '$1'"
}

uvinit() {
  uv init --bare
}

# uvi() {
#   uv pip install "$@"
# }

uvi() {
  uv add --active "$@"
}

# use uv instead of regular pip
alias pip='uv pip'
alias pip3='uv pip'

_uv_complete() {
  local base_dir="${UV_VENV_DIR:-$HOME/.virtualenvs}"
  local envs

  mapfile -t envs < <(ls -1 "$base_dir" 2>/dev/null)
  COMPREPLY=($(compgen -W "${envs[*]}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _uv_complete uvenv
complete -F _uv_complete uvrm

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
  local scripts
  mapfile -t scripts < <(find "$TMP_SCRIPT_ROOT" -type f -printf '%f\n' 2>/dev/null)
  COMPREPLY=($(compgen -W "${scripts[*]}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _tscript_complete tedit
complete -F _tscript_complete trun
complete -F _tscript_complete tdelete

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

treec() {
  local ignore_patterns=(
      "build" "dist" "target"
      "node_modules" "pnpm-lock.yaml" "yarn.lock"
      "__pycache__" "*.js.map" "*.tsbuildinfo"
      "*.d.ts" "*.o" "*.a" "*.so" "*.dll" "*.dylib"
      "*.exe" "*.out" "*.class" "*.pyc" "*.pyo"
      "a.out.*" "Cargo.lock"
    )

    tree -I "$(IFS='|'; echo "${ignore_patterns[*]}")" "$@"
}

# claude
cld() {
  if [[ "$1" == "update" || "$1" == "upgrade" ]]; then
    claude update
  else
    claude "$@"
  fi
}

# codex
cdx() {
  if [[ "$1" == "update" || "$1" == "upgrade" ]]; then
    npm install -g @openai/codex@latest
  else
    codex "$@"
  fi
}

# opencode
opc() {
  if [[ "$1" == "update" || "$1" == "upgrade" ]]; then
    opencode upgrade
  else
    opencode "$@"
  fi
}

# so loop
SO_DIR="$HOME/dotfiles/common/so"

so() {
  "$SO_DIR/so.sh" "$@"
}

# ==============================================================================
# Aliases
# ==============================================================================
alias ls='ls --color=auto'

# general
alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'
alias cp='cp -v'
alias rm='rm -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias clr='clear'
alias rst='cd ~ && clear'

alias tmr='tmux respawn-pane -k'
alias tmks='tmux kill-session'
alias tmka='tmux kill-server'
alias tmo='tmux detach'

alias sloc='cloc $(git ls-files)'
alias vim='nvim'
alias newvim='nvim $(fzf)'
alias cat='batcat --theme="Visual Studio Dark+"'
alias cu="open $1 -a \"Cursor\""
alias v="open $1 -a \"Visual Studio Code\""
alias lazygit='lg'
alias gpg-reset='gpgconf --kill gpg-agent && gpgconf --launch gpg-agent'

# git
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gf='git fetch'
alias gpush='git push'
alias gd='git diff'
alias ga='git add .'
alias gn='git new'
alias gc='git checkout'
alias gwl='git worktree list'
alias gwp='git worktree prune'

# rsync
# alias rs='rsync -av --delete'
# alias ssh_known='vim .ssh/known_hosts'

# other
# alias clang++='clang++ -Weverything
alias sai='sudo apt install'
alias sauu='sudo apt update && sudo apt upgrade && sudo apt autoremove'
alias smi='watch -n 1 nvidia-smi'
alias bb2='conda activate base2'
alias ftp='sftp'
alias python='python3'
alias changedisplay='xrandr --output Virtual-1 --mode 1920x1080'
alias nb='jupyter notebook --port=9000 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code'
alias lab='jupyter lab --port=9000 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code'
alias isim-s="$HOME/code/build/iman/resources/isaacsim/_build/linux-x86_64/release/isaac-sim.streaming.sh"
# alias startremote='systemctl --user start gnome-remote-desktop'
# alias stopremote='systemctl --user stop gnome-remote-desktop'
# alias backupshared='aws s3 sync my_directory s3://mlstorage/downloads'
# alias backuphome="aws s3 sync /home/ubuntu/ s3://backup/raven-dev-home --exclude '.*' --exclude 'miniconda3/*' --exclude 'sky_logs/*' --exclude 'shared/*'"
