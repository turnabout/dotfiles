#   _               _              
#  | |__   __ _ ___| |__  _ __ ___ 
#  | '_ \ / _` / __| '_ \| '__/ __|
#  | |_) | (_| \__ \ | | | | | (__ 
#  |_.__/ \__,_|___/_| |_|_|  \___|
#                                 


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

EDITOR="nvim"; export EDITOR

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# +----------------------------------------------------------------------------+
# | Load split bashrc files                                                    |
# +----------------------------------------------------------------------------+

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Git definitions
if [ -f ~/.bash_git ]; then
    . ~/.bash_git
fi

# Additional definitions (gitignored, machine-specific)
if [ -f ~/.bash_additional ]; then
    . ~/.bash_additional
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Add to PATH
export PATH=$PATH:/sbin:$HOME/bin:/usr/local/PhpStorm/bin
export PATH=$PATH:/home/kevin/.local/bin

# Host name & port
export HOST="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
export PORT="8080"

# Use fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use fd instead of the default find command for listing path candidates
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

ssh-add -k
clear


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
export GOPATH="$HOME/go"
export GOBIN="/home/kevin/go/bin"
export PATH=$PATH:/home/kevin/go/bin:/usr/local/go/bin

# AWO project
export AWO_ASSETS_PATH="/home/kevin/werk/awodatagen/assets"
export AWO_SPRITESHEET="/home/kevin/werk/AWO/AWO/Resources/Textures/spritesheet.png"
export AWO_JSON="/home/kevin/werk/AWO/AWO/Resources/Data/game_data.json"

