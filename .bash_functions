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

# Go to dotfiles directory
function dotfiles() {
    cd ${dotfilesdir}
}

# Sync dotfiles with remote
function syncdot() {
    cwd=$(pwd)
    cd ${dotfilesdir}
    git pull origin master
    cd ${cwd}
}

# Open vimrc in vim
function vrc() {
    nvim ~/.dotfiles/.vim/vimrc
}

# Open bashrc in vim
function brc() {
    nvim ~/.dotfiles/.bashrc 
}

# Open all bash dotfiles in new tmux session
function brca() {

    winName="bash_dots"

    # If already in a session, create new window
    if [ $TMUX ]; then

        # Create all 4 panes
        # Keep reference to pane IDs to know where to split
        newWinId=$(tmux neww -P -n ${winName} "nvim ~/.bashrc")
        bottomId=$(tmux split-window -vP -t ${newWinId} "nvim ~/.bash_functions")

        tmux split-window -hP -t ${newWinId} "nvim ~/.bash_aliases"
        tmux split-window -h -t ${bottomId} "nvim ~/.bash_git"

        # Focus the new window
        tmux selectw -t ${newWinId}

        clear
        return 1
    fi

    # Not in an existing session, create new session
    tmux new-session -s "bash_dots" -d "nvim ~/.bash_aliases"

    tmux split-window -v "nvim ~/.bash_functions"
    tmux split-window -h "nvim ~/.bash_git"
    tmux selectp -t 0
    tmux split-window -h "nvim ~/.bashrc"

    tmux attach -t bash_dots
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
