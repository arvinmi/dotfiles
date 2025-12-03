#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export FZF_DEFAULT_OPTS="--no-mouse"

# gpg agent start
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent > /dev/null 2>&1

# sdkman lazy load
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
  unfunction sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# pyenv lazy load
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

#-------------------------------------------------------------------------------
# Shell
#-------------------------------------------------------------------------------

export LANG=en_US.UTF-8
# fix ghostty terminfo (for now)
export TERM=xterm-256color

alias ibrew="arch -x86_64 /usr/local/bin/brew"
