alias ibrew="arch -x86_64 /usr/local/bin/brew"

if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export FZF_DEFAULT_OPTS="--no-mouse"

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
