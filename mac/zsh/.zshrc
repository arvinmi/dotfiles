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

# Homebrew aarch64 & x86
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

# miniconda
source ~/miniconda3/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
  export PATH="~/conda/bin:$PATH"
fi

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
# Aliases
#-------------------------------------------------------------------------------

rst() {
  cd
  clear
}

# load tmux
tma() {
  if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
  fi
}

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
