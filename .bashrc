# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
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

# Vim
vimrc="/home/kevin/.vim/vimrc"

# Xclip for copying to clipboard
# usage: echo foo | setclip
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o";

# Make directory and then move to it
mkcd () {
	mkdir "$1"
	cd "$1"
}

# Start win7 VM with Photoshop
photoshop() {
	VBoxManage startvm windows_7
	exit
}

# Start gvim and exit terminal
gvimq() {
	gvim "$1"
	exit
}

digbare() {
	dig $1 +nostats +nocomments +nocmd
}


# Aliases
alias python=python3.5
alias fucking=sudo
alias cls='clear'
alias cd..='cd ..'
alias fuck='sudo $(history -p \!\!)'
alias gc='git checkout'
alias gcn='git checkout -b '
alias ga='git addcom'
alias gpr='git pull --rebase'
alias fuckshitup='git branch --merged develop | grep -v master | grep -v develop | xargs --no-run-if-empty git branch -d'
alias gs='git status'
alias v='nvim'


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

parse_git_branch() {
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
parse_git_branch_color() {
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
# General helper functions
# 

# Get file last modified date
function lastmod() {
        stat -c %y "${1}"
}

# 
# Productivity functions
# 

# Variables
projdir="/home/${USER}/Documents/projects"
curprojdir=""
dotfilesdir="/home/${USER}/.dotfiles"
subluserdir="/home/${USER}/.config/sublime-text-3/Packages/User"

# Change to current project
function curpr() {
  cd "${projdir}/${curprojdir}"
}

# Push git changes
function gitpu() {
  git push origin master
}

# Forcefully push all changes to master
function fpu() {
    git add --all
    git commit -m "${1}"
    git push origin master
}

# Open .bashrc in subl
function sublb() {
  subl "/home/${USER}/.bashrc"
}

# Open vimrc in vim
function vrc() {
  v ~/.dotfiles/.vim/vimrc
}

# Open bashrc in vim
function brc() {
  v ~/.dotfiles/.bashrc 
}

# Merge a single file over to another branch
# $1 - The branch to patch to
# $2 - The file to use to patch
function gitpatch() {
  branch_name="$(git symbolic-ref --short -q HEAD)"
  git checkout ${1}
  git checkout ${branch_name} --patch ${2}
}


# $1 - Branch to patch to
# $2 - Branch to patch from
function gitpat() {
  git checkout "${1}"
  git merge --no-commit "${2}"
  for file in $(find . -name 'index.html'); do git checkout HEAD "$file"; done
  git commit
}
# url: http://stackoverflow.com/questions/13170263/whats-the-easiest-way-to-merge-all-but-one-change-from-a-branch-in-git]

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

# "git remote update" shortcut
function gru() {
  git remote update
}

function gm() {
  git commit
}



# 
# Other functions
# 

# Reload .bashsrc
function reloadb() {
  source ~/.bashrc
}

# Check if a command exists
function command_exists () {
  type "$1" &> /dev/null ;
}

# Sync dotfiles with repo
function syncdot() {
  cwd=$(pwd)
  cd ${dotfilesdir}
  git pull origin master
  cd ${cwd}
}

# Sync Sublime Text 3 Preferences
function syncsubl() {
  cwd=$(pwd)
  cd ${subluserdir}
  git pull origin master
  cd ${cwd}
}

# Cd to sublime user settings
function sublsettings() {
  cd ${subluserdir}
}

# Cd to dotfiles
function dotfiles() {
  cd ${dotfilesdir}
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



# 
# Momentum Functions
# 

# Pull in remote branch changes and merge develop branch into current one
# ** Only do this when checking out new feature/fix branch you're working on **
function dmer() {
  git remote update
  git merge origin/develop
}

# Cd to PhpStorm settings directory
function phpset() {
  cd "/home/${USER}/.PhpStorm2016.2/config"
}

# Ssh to production server
function prod() {
  ssh web1@ded3003.ded.reflected.net
}

# Refresh ssh-add
function refressh() {
  ssh-add ~/.ssh/id_rsa
}

# SSH to production server (for home)
function prodh() {
  ssh mv-deploy
}

# Start vagrant
function startvagrant() {
        cd ~/Document/code/vagrant-dev
        vagrant up
}

# Update my branch of filters overhaul
function ufb() {
        git checkout jfly/search-filters-overhaul
        git pull --rebase
        git checkout jfly/search-filters-vue-frontend
        git merge jfly/search-filters-overhaul
}

# Update remote branch of filters overhaul
function urb() {
        git checkout jfly/search-filters-overhaul
        git merge jfly/search-filters-vue-frontend
        git push
        git checkout jfly/search-filters-vue-frontend
}

function syncb() {
        gpr && gp && clear
}

function solar() {
        cd ~/Documents/code/travel/solar/
}

function gvagrant() {
        cd ~/Document/code/vagrant-dev
}

function navicat() {
        cd ~/Downloads/navicat112_mysql_en_x64
        ./start_navicat
}

function unfuckpart() {
        sudo ntfsfix /dev/sda1
}

export PATH="~/.config/composer/vendor/bin:$PATH":$PATH:~/bin

# Host name & port
export HOST="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
export PORT="8080"

# Start tmux automatically
if command_exists tmux ; then
  tmux attach &> /dev/null

  if [[ ! $TERM =~ screen ]]; then
      exec tmux
  fi
fi
export NVM_DIR="/home/k_pageau/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
