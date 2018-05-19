#  _               _          __                  _   _                 
# | |__   __ _ ___| |__      / _|_   _ _ __   ___| |_(_) ___  _ __  ___ 
# | '_ \ / _` / __| '_ \    | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# | |_) | (_| \__ \ | | |   |  _| |_| | | | | (__| |_| | (_) | | | \__ \
# |_.__/ \__,_|___/_| |_|___|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                      |_____|                                          


# +----------------------------------------------------------------------------+
# | General helper functions                                                   |
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

# Mount USB device
function mountusb() {
    sudo mount /dev/$1 /media/usb
}

# Unmount USB device
function umountusb() {
    sudo umount /media/usb
}

# Continually output tree, ignoring files ignored by git.
# Has to be run from the root of the git repo
function gtree {
    git_ignore_files=$(< .gitignore)
    ignore_pattern=$(echo $git_ignore_files | tr ' ' '|')

    if git status &> /dev/null && [[ -n "${ignore_pattern}" ]]; then
      watch -ct -n 0.5 "tree --dirsfirst -C -I '${ignore_pattern}'"
    else 
      tree --dirsfirst -C
    fi
}

# +----------------------------------------------------------------------------+
# | Quick go-to/open                                                           |
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
    args=(
        "nvim ~/.bash_aliases" 
        "nvim ~/.bash_functions" 
        "nvim ~/.bashrc" 
        "nvim ~/.bash_git"
        "newdotss"
    )

    tsplit "${args[@]}"
}

# Split into 4 panes
function tms() {

    # Already in tmux session, just split
    if [ $TMUX ]; then
        # Split 3 times
        tmux split-window -h
        tmux split-window -v
        tmux split-window -v -t 0
        clear
        return 1
    fi

    # No tmux session, create one

    # Generate random session name
    sessName=$(
        cat /dev/urandom | 
        tr -dc 'a-zA-Z0-9' | 
        fold -w 12 | 
        head -n 1
    )

    tmux new-session -s ${sessName} -d

    # Create 4 panes
    winId=$(tmux neww -P -n ${sessName})
    tmux split-window -vP -t ${sessName}

    tmux split-window -h -t ${sessName}
    tmux split-window -h -t ${winId}

    tmux attach -t ${sessName}
    clear
}

# +----------------------------------------------------------------------------+
# | Other Install-specific helpers                                             |
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

# Reload sxhkd configuration file
function sxhkdre() {
    pkill -USR1 -x sxhkd
    echo "sxhkd Config Reloaded"
}

# +----------------------------------------------------------------------------+
# | Internal functions                                                         |
# +----------------------------------------------------------------------------+

#
# Open tmux session or window with 4 panes.
#
# Globals:
#   None
# 
# Arguments:
#   $@ Array containing 4 command strings to execute 
#      in all 4 panes.
#      Panes are opened w/ corresponding commands in order:
#      0 1
#      2 3
#
#      Last index contains the new window name.
#
# Returns:
#   None
#
function tsplit() {
    # Get commands to be opened in 4 panes & window name
    cmds=("$@")
    winName=${cmds[4]}

    if [ $TMUX ]; then

        # If already in a session, create new window
        newWinId=$(tmux neww -P -n ${winName} "${cmds[0]}")
    else

        # If not in an existing session, create new session
        tmux new-session -s ${winName} -d
        newWinId=$(tmux neww -P -n ${winName} "${cmds[0]}")
    fi

    # Create remaining 3 panes
    # Keep reference to bottom-left pane ID to know where to split
    bottomId=$(tmux split-window -vP -t ${newWinId} "${cmds[2]}")

    tmux split-window -h -t ${bottomId} "${cmds[3]}"
    tmux split-window -hP -t ${newWinId} "${cmds[1]}"

    clear

    # Focus new window or attach new session
    if [ $TMUX ]; then
        tmux selectw -t ${newWinId}
    else
        tmux attach -t ${winName}
    fi
}
