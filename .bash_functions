#                                                                 
#     ▄▀▀                         ▄      ▀                        
#   ▄▄█▄▄  ▄   ▄  ▄ ▄▄    ▄▄▄   ▄▄█▄▄  ▄▄▄     ▄▄▄   ▄ ▄▄    ▄▄▄  
#     █    █   █  █▀  █  █▀  ▀    █      █    █▀ ▀█  █▀  █  █   ▀ 
#     █    █   █  █   █  █        █      █    █   █  █   █   ▀▀▀▄ 
#     █    ▀▄▄▀█  █   █  ▀█▄▄▀    ▀▄▄  ▄▄█▄▄  ▀█▄█▀  █   █  ▀▄▄▄▀ 
#                                                                 


# +----------------------------------------------------------------------------+
# + General helper functions                                                   |
# +----------------------------------------------------------------------------+

# Get file last modified date
function lastmod() {
    stat -c %y "${1}"
}

# Make directory & move to it
function mkcd () {
	mkdir "$1"
	cd "$1"
}

# Dig with simple output
function digbare() {
	dig $1 +nostats +nocomments +nocmd
}

# Check if a command exists
function command_exists () {
  type "$1" &> /dev/null ;
}


# +----------------------------------------------------------------------------+
# + Quick go-to/open                                                           |
# +----------------------------------------------------------------------------+

projdir="/home/${USER}/projects"
dotfilesdir="/home/${USER}/.dotfiles"

# Go to current project directory
function curpr() {
  cd "${projdir}"
}

# Sync dotfiles with remote
function syncdot() {
  cwd=$(pwd)
  cd ${dotfilesdir}
  git pull origin master
  cd ${cwd}
}

# Go to dotfiles
function dotfiles() {
  cd ${dotfilesdir}
}

# Open vimrc in vim
function vrc() {
  nvim ~/.dotfiles/.vim/vimrc
}

# Open bashrc in vim
function brc() {
  nvim ~/.dotfiles/.bashrc 
}


# +----------------------------------------------------------------------------+
# + Other Install-specific helpers                                             |
# +----------------------------------------------------------------------------+

# Reload .bashsrc
function reloadb() {
  source ~/.bashrc
}

# Un-fuck sda1 partition
function unfucksda1() {
    sudo ntfsfix /dev/sda1
    sudo mount -o remount,rw /dev/sda1 /media/kevin/data
}

# Open C book
function cb() {
    evince /media/kevin/data/ebooks/The_C_Programming_Language_Ritchie_\&_Kernighan.pdf
}
