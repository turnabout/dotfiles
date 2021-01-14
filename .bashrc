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

EDITOR="vim"; export EDITOR

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

# Global variables
export HOST="127.0.0.1"
export PORT="8080"

# Cd into home directory
# cd ~

# Fix global npm modules
PATH=~/AppData/Roaming/npm:$PATH

alias pserver="python -m SimpleHTTPServer 8000"

# Quick aliases
alias depl="npm run sass-prod && npm run js-prod"

alias ogl="cd /f/OpenGL_Experiments/OpenGL_Experiments && clear"

export SDL2DIR="F:\c\SDL2-2.0.10"
export SDL2IMAGEDIR="F:\c\SDL2_image-2.0.5"
export SDL2TTFDIR="F:\c\SDL2_ttf-2.0.15"

# Qt4
PATH=/c/Qt/4.8.5/bin:$PATH
PATH=/c/glew/bin:$PATH
PATH=/c/glew:$PATH
PATH=/c/glew/lib:$PATH

# MinGW binaries
PATH=/c/MinGW/bin:$PATH
PATH=/c/MinGW/include:$PATH
PATH=/c/MinGW/lib:$PATH

# Emscripten paths & env variables
PATH=~/AppData/Roaming/npm:$PATH

PATH=/f/web/emsdk:$PATH
PATH=/f/web/emsdk/fastcomp/emscripten:$PATH
# PATH=/f/web/emsdk/node/8.9.1_64bit/bin:$PATH
PATH=/f/web/emsdk/python/2.7.13.1_64bit/python-2.7.13.amd64:$PATH
PATH=/f/web/emsdk/java/8.152_64bit/bin:$PATH

EMSDK=/f/web/emsdk
EM_CONFIG=/c/Users/kevin/.emscripten
EMSDK_NODE=/f/web/emsdk/node/8.9.1_64bit/bin/node.exe
EMSDK_PYTHON=/f/web/emsdk/python/2.7.13.1_64bit/python-2.7.13.amd64/python.exe
JAVA_HOME=/f/web/emsdk/java/8.152_64bit

# C# compiler
PATH=/c/Windows/Microsoft.NET/Framework64/v4.0.30319:$PATH

# Compiling go archive for C
PATH=/c/TDM-GCC-32/bin:$PATH
PATH=$GOPATH/bin/windows_386:$PATH
PATH=/f/win_programs/nvm/nvm.exe:$PATH

# AWO
# Make output path
export AWO_GAME_OUTPUT="/f/AWO_web/src/assets/AWO.js"

# Shortcuts
alias todo="v ~/Desktop/todo"

alias aw="cd /f/AWO && clear"
alias aww="cd /f/AWO_web && clear"
alias aws="cd /f/go/src/github.com/turnabout/awodatagen && clear"
alias awx="cd /f/AWO_experimental && clear"
alias awse="cd /f/go/src/github.com/turnabout/server/ && clear"

alias awg="awodatagen.exe"
alias awi="go install /f/go/src/github.com/turnabout/awodatagen/cmd/awodatagen"
alias awig="go install /f/go/src/github.com/turnabout/awodatagen/cmd/awodatagen && awodatagen.exe"

alias awr="v /f/AWO/AWO/Resources/Data/game_data.json && clear"

alias awb="cd /f/go/src/github.com/turnabout/awossgen && go run . && cd - && clear"

alias sta="v /f/go/src/github.com/turnabout/awossgen/inputs/additional/stages.json"

alias cb="cd /f/click_bot && clear"

# AWO Server public assets directory
export AWO_PUBLIC_ASSETS="/f/go/src/github.com/turnabout/server/assets/public"

alias air="air -c ~/.air.conf"
