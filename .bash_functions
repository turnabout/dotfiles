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
function mkcd() {
    mkdir "$1"
    cd "$1"
}

# Mount USB device
function mountusb() {
    sudo mount /dev/$1 /media/usb
}

# Unmount USB device
function umountusb() {
    sudo umount /media/usb
}

# Toggle between us/ca keyboard layouts
function tl() {
    layout=`setxkbmap -query | grep layout | tail -c 3`

    if [ $layout == "ca" ]; then
        echo "Switching to US"
        setxkbmap us
    else
        echo "Switching to CA-FR"
        setxkbmap ca
    fi
}

# Toggle between muted/unmuted audio
function tm() {
    muted=`pacmd list-sinks | awk '/muted/ { print $2 }'`

    if [ $muted == "no" ]; then
        pactl set-sink-mute 0 1
    else
        pactl set-sink-mute 0 0
    fi
}

# Get usage data for a process
function psgr() {
    ps aux | head -n 1
    ps aux | grep ${1}
}

# Determine what processes are listening on what ports, protocols & interfaces
# https://gist.github.com/Frick/0c22207f0445477a66e9
function listening {
    if [ "${1}" = "-h" ]; then
        echo "Usage: listening [t|tcp|u|udp] [ps regex]"
        return
    fi
    DISP="both"
    NSOPTS="tu"
    if [ "${1}" = "t" -o "${1}" = "tcp" ]; then
        DISP="tcp"
        NSOPTS="t"
        shift
    elif [ "${1}" = "u" -o "${1}" = "udp" ]; then
        DISP="udp"
        NSOPTS="u"
        shift
    fi
    FILTER="${@}"
    PORTS_PIDS=$(sudo netstat -"${NSOPTS}"lnp | tail -n +3 | tr -s ' ' | sed -n 's/\(tcp\|udp\) [0-9]* [0-9]* \(::\|0\.0\.0\.0\|127\.[0-9]*\.[0-9]*\.[0-9]*\):\([0-9]*\) .* \(-\|\([0-9-]*\)\/.*\)/\3 \1 \5 \2/p' | sed 's/\(::\|0\.0\.0\.0\)/EXTERNAL/' | sed 's/127\.[0-9]*\.[0-9]*\.[0-9]*/LOCALHOST/' | sort -n | tr ' ' ':' | sed 's/::/:-:/' | sed 's/:$//' | uniq)
    PS=$(sudo ps -e --format '%p %a')
    echo -e '   Port - Protocol - Interface - Program\n-----------------------------------------------'
    for PORT_PID in ${PORTS_PIDS}; do
        PORT=$(echo ${PORT_PID} | cut -d':' -f1)
        PROTOCOL=$(echo ${PORT_PID} | cut -d':' -f2)
        PID=$(echo ${PORT_PID} | cut -d':' -f3)
        INTERFACE=$(echo ${PORT_PID} | cut -d':' -f4)
        if [ "${PROTOCOL}" != "${DISP}" -a "${DISP}" != "both" ]; then
            continue
        fi
        if [ "${PID}" = "-" ]; then
            if [ "${FILTER}" != "" ]; then
                continue
            fi
            printf "%7s - %8s - %9s - -\n" "${PORT}" "${PROTOCOL}" "${INTERFACE}"
        else
            PROG=$(echo "${PS}" | grep "^ *${PID}" | grep -o '[0-9] .*' | cut -d' ' -f2-)
            if [ "${FILTER}" != "" ]; then
                echo "${PROG}" | grep -q "${FILTER}"
                if [ $? -ne 0 ]; then
                    continue
                fi
            fi
            printf "%7s - %8s - %9s - %s\n" "${PORT}" "${PROTOCOL}" "${INTERFACE}" "${PROG}"
        fi
    done
}

# function Extract for common file formats

SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)         arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

# +----------------------------------------------------------------------------+
# | IDE-like utilities                                                         |
# +----------------------------------------------------------------------------+
# Search/replace $1 occurences by $2 in all files of directory & subdirectories
function sr() {
    grep -rli "$1" * | xargs -i@ sed -i "s/$1/$2/g" @
}

# +----------------------------------------------------------------------------+
# | Quick go-to/open                                                           |
# +----------------------------------------------------------------------------+
dotfilesdir="/home/${USER}/.dotfiles"

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

# Open vimrc
function vrc() {
    ${EDITOR} ~/.dotfiles/.vim/vimrc
}

# Open bashrc
function brc() {
    ${EDITOR} ~/.dotfiles/.bashrc 
}

# Open additional bash commands
function ba() {
    ${EDITOR} ~/.bash_additional
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

# Daily setup
function ds() {
    phpstorm &
    google-chrome &
    chromium &
    sleep 300
    i3-msg '[class="Chromium"] move to workspace "4"'
    i3-msg '[class="jetbrains-phpstorm"] move to workspace "1"'
    urxvt -e sh -c "cd ~/werk/ubisoft/src/;bash" &
    exit
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
