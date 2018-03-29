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

# ls aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


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
alias monod="flatpak run com.xamarin.MonoDevelop &"
alias sicp="cd /media/data/sicp"

# +----------------------------------------------------------------------------+
# | Werk related                                                               |
# +----------------------------------------------------------------------------+
alias prod="ssh production"
alias staging="ssh staging"
alias solar="cd ~/Documents/code/travel/solar/"
alias navicat="cd ~/Downloads/navicat112_mysql_en_x64 && ./start_navicat"
