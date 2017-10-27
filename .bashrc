#                                            
#   █                    █                   
#   █▄▄▄    ▄▄▄    ▄▄▄   █ ▄▄    ▄ ▄▄   ▄▄▄  
#   █▀ ▀█  ▀   █  █   ▀  █▀  █   █▀  ▀ █▀  ▀ 
#   █   █  ▄▀▀▀█   ▀▀▀▄  █   █   █     █     
#   ██▄█▀  ▀▄▄▀█  ▀▄▄▄▀  █   █   █     ▀█▄▄▀ 
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load split bashrc files
# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
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

# Environment variables
VIMRUNTIME="/usr/share/vim/vim74"



# 
# Show git branch in prompt START
# 

# Colors for the prompt
red="\033[0;31m"
white="\033[0;37m"
green="\033[0;32m"

# Brackets needed around non-printable characters in PS1
ps1_red='\['"$red"'\]'
ps1_green='\['"$green"'\]'
ps1_white='\['"$white"'\]'

function parse_git_branch() {
    gitstatus=`git status 2> /dev/null`
    if [[ `echo $gitstatus | grep "Changes to be committed"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1***)/'
    elif [[ `echo $gitstatus | grep "Changes not staged for commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1**)/'
    elif [[ `echo $gitstatus | grep "Untracked"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1*)/'
    elif [[ `echo $gitstatus | grep "nothing to commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    else
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1?)/'
    fi
}

# Echo a non-printing color character depending on whether or not the current git branch is the master    
# Does NOT print the branch name                                                                          
# Use the parse_git_branch() function for that.                                                           
function parse_git_branch_color() {
    br=$(parse_git_branch)
    if [[ $br == "(master)" || $br == "(master*)" || $br == "(master**)" || $br == "(master***)" ]]; then
        echo -e "${red}"
    else
        echo -e "${green}"
    fi
}

# No color:
#export PS1="@\h:\W\$(parse_git_branch) \$ "

# With color:
# export PS1="$ps1_red\u:$ps1_white\W\[\$(parse_git_branch_color)\]\$(parse_git_branch) $ps1_red\$$ps1_white "
export PS1="$ps1_red\u:$ps1_white\W\[\$(parse_git_branch_color)\]\$(parse_git_branch) $ps1_red\$$ps1_white "


# 
# Git
# 

# Push changes to current branch
function gp() {
  branch_name="$(git symbolic-ref HEAD 2>/dev/null --short)"
  git push origin "${branch_name}"
}

# `ga` and then `gp`, followed by screen clear
function gap() {
  ga
  gp
  clear
}

# Remote update
function gru() {
  git remote update
}

# git diff shortcut
function gd() {
  git diff
}

# git log shortcut
function gl() {
  if [ ${1} ]; then 
    git log -${1}
  else
    git log
  fi
}

# git reset --hard shortcut
function grh() {
  git reset --hard
}


# Add to PATH
export PATH=$PATH:/sbin:~/bin

# Host name & port
export HOST="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
export PORT="8080"

# Load nvm
export NVM_DIR="/home/k_pageau/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load xbindkeys
if command_exists xbindkeys; then
  xbindkeys
fi
