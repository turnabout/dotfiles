#                                                                 
#     ▄▀▀                         ▄      ▀                        
#   ▄▄█▄▄  ▄   ▄  ▄ ▄▄    ▄▄▄   ▄▄█▄▄  ▄▄▄     ▄▄▄   ▄ ▄▄    ▄▄▄  
#     █    █   █  █▀  █  █▀  ▀    █      █    █▀ ▀█  █▀  █  █   ▀ 
#     █    █   █  █   █  █        █      █    █   █  █   █   ▀▀▀▄ 
#     █    ▀▄▄▀█  █   █  ▀█▄▄▀    ▀▄▄  ▄▄█▄▄  ▀█▄█▀  █   █  ▀▄▄▄▀ 
#                                                                 
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
    ${EDITOR} ~/.dotfiles/.vim/vimrc
}

# Open bashrc in vim
function brc() {
    ${EDITOR} ~/.dotfiles/.bashrc 
}

# Open all bash dotfiles in new tmux session
function brca() {

    # Bash dotfiles to be opened in 4-way panes.
    # Opened in order:
    # 0 1
    # 2 3
    brcfiles=(".bashrc" ".bash_aliases" ".bash_git" ".bash_functions")

    # Window name for the bash dotfiles
    winName="bash_dots"

    if [ $TMUX ]; then

        # If already in a session, create new window
        newWinId=$(tmux neww -P -n ${winName} "${EDITOR} ~/${brcfiles[0]}")
    else

        # If not in an existing session, create new session
        tmux new-session -P -s "bash_dots" -d
        newWinId=$(tmux neww -P -n ${winName} "${EDITOR} ~/${brcfiles[0]}")
    fi

    # Create all 4 panes
    # Keep reference to bottom-left pane ID to know where to split
    bottomId=$(tmux split-window -vP -t ${newWinId} "${EDITOR} ~/${brcfiles[2]}")

    tmux split-window -hP -t ${newWinId} "${EDITOR} ~/${brcfiles[1]}"
    tmux split-window -h -t ${bottomId} "${EDITOR} ~/${brcfiles[3]}"

    clear

    # Focus new window or attach new session
    if [ $TMUX ]; then
        tmux selectw -t ${newWinId}
    else
        tmux attach -t ${winName}
    fi
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
