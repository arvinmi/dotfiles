#!/bin/zsh

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
PROMPT="%n@%M:%B%F{002}%~%f%b$ "

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias rm='rm -i'
alias sloc='cloc $(git ls-files)'
alias code='code .'
alias vim='nvim'
alias newvim='nvim $(fzf)'

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
# alias clangall='clang++ -Weverything'
alias gcc='gcc-13'
alias g++='g++-13'
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

#-------------------------------------------------------------------------------
# Path
#-------------------------------------------------------------------------------

# Plugins
eval $(thefuck --alias fix)
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
