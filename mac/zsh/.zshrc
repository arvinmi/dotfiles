#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

if [ -f ~/.zprofile ]; then
  source ~/.zprofile
fi
export PATH="$HOME/.local/bin:$PATH"
ZSH_DISABLE_COMPFIX="true"

# docker cli completions
fpath=(/Users/kofa/.docker/completions $fpath)
autoload -Uz compinit
compinit

# plugins
# eval $(thefuck --alias fix)

# openssh
PATH=$(brew --prefix openssh)/bin:$PATH

# aws
# export AWS_PROFILE=sandbox

# brew aarch64 & x86
export HOMEBREW_BREWFILE=~/Brewfile
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"

# oh my zsh
export ZSH="/Users/$USER/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# chromium build tools
export PATH="$PATH:/Users/$USER/build/depot_tools"

# lm studio cli (lms)
export PATH="$PATH:/Users/kofa/.lmstudio/bin"

# miniconda
if [ -f ~/miniconda3/etc/profile.d/conda.sh ]; then
  source ~/miniconda3/etc/profile.d/conda.sh
fi

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

# editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
fi

bindkey -s ^f "~/scripts/tmux-sessionizer.sh\n"

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------

PROMPT="%n@%M:%B%F{cyan}%~%f%b$ "

#-------------------------------------------------------------------------------
# Functions & Completions
#-------------------------------------------------------------------------------

lenv() {
  export GEMINI_API_KEY=$(op read "op://Personal/Gemini API Key/key")
}

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
  local -a sessions
  sessions=(${(f)"$(tmux list-sessions -F '#S' 2>/dev/null)"})
  _describe 'tmux sessions' sessions
}
compdef _tma_complete tma

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
  conda activate "$1"
}

cnd() {
  conda deactivate
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

# uv uenv
uvenv() {
  local env_path="$HOME/.virtualenvs/$1"
  if [[ -z "$1" ]]; then
    echo "Usage: uvenv <env-name>"
    return 1
  fi
  local py="/opt/homebrew/bin/python3"
  if [[ ! -x "$py" ]]; then
    return 1
  fi
  if [[ -d "$env_path" ]]; then
    export UV_PROJECT_ENVIRONMENT="$env_path"
    source "$env_path/bin/activate"
  else
    mkdir -p "$HOME/.virtualenvs"
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
  local -a envs
  envs=(${(f)"$(ls -1 $base_dir 2>/dev/null)"})
  compadd "$@" -- $envs
}
compdef _uv_complete uvenv
compdef _uv_complete uvrm

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
    npm install -g @anthropic-ai/claude-code
  else
    claude "$@"
  fi
}

# codex
cdx() {
  if [[ "$1" == "update" || "$1" == "upgrade" ]]; then
    npm install -g @openai/codex@latest
  else
    codex --search "$@" -c model_reasoning_summary_format=experimental
  fi
}

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

# general
unalias ls
alias ls='gls --color=auto'
export LS_COLORS='*.sh=31:di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

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
alias cat='bat --theme="Visual Studio Dark+"'
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

# other
# alias clangall='clang++ -Weverything'
alias buuc='brew update && brew upgrade && brew cleanup'
alias ibuuc='ibrew update && ibrew upgrade && ibrew cleanup'
alias ftp='sftp'
alias x86_64='arch -x86_64'
alias arm64='arch -arm64'
alias rs='rsync -av --delete'
alias brewfile='brew bundle dump'
alias bb2='conda activate base2'
alias python='python3'
alias nb='jupyter notebook --port=9000 --notebook-dir=${HOME}/code'
alias lab='jupyter lab --port=9000 --notebook-dir=${HOME}/code'
alias del_ds_files='find . -name ".DS_Store" -type f -delete'
