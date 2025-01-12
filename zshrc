#!/bin/zsh

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

# Plugins
# eval $(thefuck --alias fix)
source "/Users/$USER/.sdkman/bin/sdkman-init.sh"
# source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

PATH=$(brew --prefix openssh)/bin:$PATH

# AWS
# export AWS_PROFILE=sandbox

# Homebrew aarch64 & x86
export HOMEBREW_BREWFILE=~/Brewfile
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"

# Oh My Zsh
export ZSH="/Users/$USER/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Pyenv version
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# UV
export PATH="$HOME/.local/bin:$PATH"

# Miniconda
source ~/miniconda3/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
        export PATH="~/conda/bin:$PATH"
fi

# Sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Chromium build tools
export PATH="$PATH:/Users/$USER/build/depot_tools"

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------
export LANG=en_US.UTF-8

ZSH_DISABLE_COMPFIX="true"
bindkey "\t" end-of-line

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
fi

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
PROMPT="%n@%M:%B%F{cyan}%~%f%b$ "

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
unalias ls
alias ls='gls --color=auto'
export LS_COLORS='*.sh=31:di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
alias l='ls -ab'
alias la='ls -la'
alias ll='ls -lh'
alias rm='rm -i'
alias sloc='cloc $(git ls-files)'
alias c='cursor'
alias vim='nvim'
alias newvim='nvim $(fzf)'
alias cat='bat --theme="Visual Studio Dark+"'

# Git aliases
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gf='git fetch'
alias gpush='git push'
alias gd='git diff'
alias ga='git add .'
alias gc='git checkout'

# Other
# alias cl='clear'
alias cl='printf "\033[H\033[2J"'
alias clear='printf "\033[H\033[2J"'
# alias clangall='clang++ -Weverything'
alias gcc='gcc-14'
alias g++='g++-14'
alias x86_64='arch -x86_64'
alias arm64='arch -arm64'
alias rs='rsync -av --delete'
alias brewfile='brew bundle dump'
alias tt='conda activate testing'
alias pip='pip3'
alias python='python3'
alias nb='jupyter notebook --port=9000 --notebook-dir=${HOME}/code'
alias lab='jupyter lab --port=9000 --notebook-dir=${HOME}/code'
alias del_ds_files='find . -name ".DS_Store" -type f -delete'
