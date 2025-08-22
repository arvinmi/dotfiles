# ==============================================================================
# Paths
# ==============================================================================

# junist
export EDITOR='vim'
export PATH=~/.local/share/junest/bin:$PATH:~/.junest/usr/bin_wrappers

# history
HISTCONTROL=ignoreboth
HISTSIZE=5000000
HISTFILESIZE=5000000

# general module load
# module load gcc llvm-clang

# cuda module load
# module load cuda/12.6

# pip and hftransformers cache dir
export PIP_CACHE_DIR=${HOME}/share/.cache/pip
export TRANSFORMERS_CACHE=${HOME}/share/.cache/huggingface

# cargo
#. "$HOME/.cargo/env"

# anaconda (miniconda)
#source ~/miniconda3/etc/profile.d/conda.sh
#if [[ -z ${CONDA_PREFIX+x} ]]; then
#        export PATH="~/conda/bin:$PATH"
#fi

source /usr/local/apps/anaconda/2024.06/etc/profile.d/conda.sh
if [[ -z ${CONDA_PREFIX+x} ]]; then
        export PATH="/usr/local/apps/anaconda/2023.03/bin:$PATH"
fi
# module load anaconda/24.3

# uv
export PATH="$HOME/.local/bin:$PATH"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# remove old slurm log dirs
if [ -d "$SLURM_LOG_DIR" ]; then
    find "$SLURM_LOG_DIR/" \
        -mindepth 1 \
        -type f \
        -mtime +7 | xargs -I {} -P 8 rm -r {} 2>> $cleanup_logfile
# else
   # echo "Missing slurm log directory: '$SLURM_LOG_DIR'"
fi

# for cs 340
alias forever='./node_modules/forever/bin/forever'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # this loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # this loads nvm bash_completion

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
# export PS1="\[\e[1;32m\]\\u@\\H\[\e[00m\]:\[\e[35m\]\\w\[\e[00m\]$ "
# export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export PS1="\[\e[1;32m\]\u@\H\[\e[00m\]:\[\e[0;35m\]\w\[\e[00m\]\$ "

export LS_COLORS='di=0;35:ln=1;92:ex=1;92'
# export LSCOLORS=cxgxfxexbxegedabagacad
color_prompt=yes
export CLICOLOR=1

# ==============================================================================
# Functions & Completions
# ==============================================================================

scancelme() {
    read -p "Really cancel all your runs? [N/y] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelling all runs for $USER"
        scancel -u $USER
    else
        echo "Aborting"
    fi
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
alias vi='/usr/bin/vim'
# alias vim='nvim'
alias newvim='vim $(fzf)'
alias cl='clear'

# git
alias git='/usr/local/apps/git/2.32/bin/git'
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gf='git fetch'
alias gpush='git push'
alias gd='git diff'
alias ga='git add .'
alias gc='git checkout'

# osugpu
alias squ='squeue -u "$USER"'
alias smi='watch -n 1 nvidia-smi'
alias sing='singularity'
# alias modu='module load python3/3.10 anaconda/2023.03 cuda/12.2 gcc/12.2 llvm-clang/14.0.0 git/2.32'
alias gpu='sh ${HOME}/dotfiles/server/scripts/scripts/osugpu/accgpu.sh'
alias gpulong='sh ${HOME}/dotfiles/server/scripts/scripts/osugpu/accgpulong.sh'

# other
# alias clang++='clang++ -Weverything
alias bb2='conda activate base2'
alias pip='pip3'
alias python='python3'
alias nb='jupyter notebook --port=8096 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code/fun'
alias lab='jupyter lab --port=8096 --ip=0.0.0.0 --no-browser --notebook-dir=${HOME}/code/fun'
alias jun='junest -b "--bind ${HOME}/share /nfs/hpc/share/mirtoraa" -- /usr/bin/bash'
# alias jun2='export PS1="[\u@\h \W]\\$ "'
alias changedisplay='xrandr --output Virtual-1 --mode 1920x1080'
# alias backupshared='aws s3 sync my_directory s3://mlstorage/downloads'
# alias backuphome="aws s3 sync /home/ubuntu/ s3://backup/raven-dev-home --exclude '.*' --exclude 'miniconda3/*' --exclude 'sky_logs/*' --exclude 'shared/*'"
