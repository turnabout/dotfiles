#                                                  
#          ▀▀█      ▀                               
#    ▄▄▄     █    ▄▄▄     ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄  
#   ▀   █    █      █    ▀   █  █   ▀  █▀  █  █   ▀ 
#   ▄▀▀▀█    █      █    ▄▀▀▀█   ▀▀▀▄  █▀▀▀▀   ▀▀▀▄ 
#   ▀▄▄▀█    ▀▄▄  ▄▄█▄▄  ▀▄▄▀█  ▀▄▄▄▀  ▀█▄▄▀  ▀▄▄▄▀ 
#                                                  

# Built-in command helpers
alias fucking="sudo"
alias fuck='sudo $(history -p \!\!)'
alias sudo="sudo "
alias cls="clear"
alias cd..='cd ..'

# Git
alias gs="git status"
alias gc="git checkout"
alias gcn="git checkout -b "
alias ga="git add -A && git commit"
alias gd="git diff"
alias gpr="git pull --rebase"
alias fuckshitup="git branch --merged develop | grep -v master | grep -v develop | xargs --no-run-if-empty git branch -d"

# Xclip
# usage: echo foo | setclip
#        echo `getclip`
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o";

# Werk related
alias prod="ssh production"
alias staging="ssh staging"
alias solar="cd ~/Documents/code/travel/solar/"
alias navicat="cd ~/Downloads/navicat112_mysql_en_x64 && ./start_navicat"

# ls aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Other programs/shortcuts
alias python=python3.5
alias v="nvim"
alias def="/usr/bin/sdcv"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
