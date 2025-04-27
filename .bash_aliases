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
alias cd..="cd .."
alias cd-="cd - && clear"
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias la="ls -oa"
alias lo="ls -o"

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
alias reloadb="source ~/.bashrc"
alias rb="reloadb"
alias up="cd ../"
alias lm="lastmod"
alias pwdc="pwd | setclip"

# +----------------------------------------------------------------------------+
# | Program shortcuts                                                          |
# +----------------------------------------------------------------------------+

# Xclip copy/paste
# usage: echo foo | setclip ...... echo `getclip`
alias setclip="xclip -selection c"
alias sc="setclip"
alias getclip="xclip -selection c -o";
alias pwdsc="pwd | sc"

alias v="nvim"
alias killvlc="kill -9 `pgrep vlc`"
alias tv="xrandr --output HDMI-A-0 --mode 1920x1080 --set underscan on --left-of DVI-D-0"
alias pserver="python3 -m http.server 8000"
alias goi="go install"

# Simple HTTP server (localhost:1234)
alias sse="python3.9 -m http.server 1234 --bind 127.0.0.1"
alias ssv="sse"

alias bat="batcat"
alias t="task"

# +----------------------------------------------------------------------------+
# | Path shortcuts                                                             |
# +----------------------------------------------------------------------------+
alias werk="cd ~/werk"
alias lbin="cd ~/.local/bin && clear"
alias bad="NO_NVIM_TREE=1 nvim ~/.bash_additional"

