#  _               _              _ _                     
# | |__   __ _ ___| |__      __ _| (_) __ _ ___  ___  ___ 
# | '_ \ / _` / __| '_ \    / _` | | |/ _` / __|/ _ \/ __|
# | |_) | (_| \__ \ | | |  | (_| | | | (_| \__ \  __/\__ \
# |_.__/ \__,_|___/_| |_|___\__,_|_|_|\__,_|___/\___||___/
#                      |_____|                            


# +----------------------------------------------------------------------------+
# | Built-in commands                                                          |
# +----------------------------------------------------------------------------+
alias fucking="sudo"
alias fuck='sudo $(history -p \!\!)'
alias sudo="sudo "
alias cls="clear"
alias cd..='cd ..'

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Get local ip
alias getip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

alias dfi="dotfiles"

# +----------------------------------------------------------------------------+
# | Program shortcuts                                                          |
# +----------------------------------------------------------------------------+

# Xclip copy/paste
# usage: echo foo | setclip ...... echo `getclip`
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o";

alias python=python3.5
alias v="nvim"
alias def="/usr/bin/sdcv"
alias killvlc="kill -9 `pgrep vlc`"
alias sicp="cd /media/data/sicp"
alias tv="xrandr --output HDMI-A-0 --mode 1920x1080 --set underscan on --left-of DVI-D-0"

# Fix partitions (home)
alias fixwerk="sudo umount --force  /media/werk && sudo ntfsfix /dev/sdc2 && sudo mount -o rw /media/werk"
alias fixdata="sudo umount --force  /media/data && sudo ntfsfix /dev/sda1 && sudo mount -o rw /media/data"


# +----------------------------------------------------------------------------+
# | Werk related                                                               |
# +----------------------------------------------------------------------------+
alias phpstorm="/usr/local/PhpStorm/bin/phpstorm.sh &"

alias werk="cd ~/werk/"
alias r="cd ~/werk/flighthub/travel/ota-react"
alias d="cd ~/werk/flighthub/travel/docroots"
alias s="cd ~/werk/flighthub/travel/solar"
alias f="cd ~/werk/flighthub/travel/genesis-frontend"

alias re="cd ~/werk/react-playground"
alias p="cd ~/werk/poke"

alias va="cd ~/werk/flighthub/vagrant"
alias vssh="va && vagrant ssh"
alias vup="va && vagrant up"

alias navicat="~/Downloads/navicat15-mysql-en.AppImage &"
