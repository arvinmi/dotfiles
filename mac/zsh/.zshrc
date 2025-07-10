#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

# plugins
# eval $(thefuck --alias fix)

# fix ghostty terminfo (for now)
export TERM=xterm-256color

# sdkman
source "/Users/$USER/.sdkman/bin/sdkman-init.sh"

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

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# pyenv version
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# uv
export PATH="$HOME/.local/bin:$PATH"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# chromium build tools
export PATH="$PATH:/Users/$USER/build/depot_tools"

# lm studio cli (lms)
export PATH="$PATH:/Users/kofa/.lmstudio/bin"

# gpg agent start
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent > /dev/null 2>&1

# miniconda
source ~/miniconda3/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
  export PATH="~/conda/bin:$PATH"
fi

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

export LANG=en_US.UTF-8
ZSH_DISABLE_COMPFIX="true"

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

# uv uenv
unew() {
  python3 -m venv "$HOME/.virtualenvs/$1"
}

urm() {
  rm -rf "$HOME/.virtualenvs/$1"
}

uenv() {
  source "$HOME/.virtualenvs/$1/bin/activate"
}

_uv_complete() {
  local -a envs
  envs=(${(f)"$(ls -1 "$HOME/.virtualenvs" 2>/dev/null)"})
  _describe 'virtualenvs' envs
}
compdef _uv_complete uv-env
compdef _uv_complete uv-rm

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

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

# general
unalias ls
alias ls='gls --color=auto'
export LS_COLORS='*.sh=31:di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
alias l='ls -ab'
alias la='ls -la'
alias ll='ls -lh'
alias rm='rm -i'
alias sloc='cloc $(git ls-files)'
alias vim='nvim'
alias newvim='nvim $(fzf)'
alias cat='bat --theme="Visual Studio Dark+"'
alias cu="open $1 -a \"Cursor\""
alias v="open $1 -a \"Visual Studio Code\""
alias cl='clear'
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

# other
# alias clangall='clang++ -Weverything'
alias x86_64='arch -x86_64'
alias arm64='arch -arm64'
alias rs='rsync -av --delete'
alias brewfile='brew bundle dump'
alias bb2='conda activate base2'
alias pip='pip3'
alias python='python3'
alias nb='jupyter notebook --port=9000 --notebook-dir=${HOME}/code'
alias lab='jupyter lab --port=9000 --notebook-dir=${HOME}/code'
alias del_ds_files='find . -name ".DS_Store" -type f -delete'
