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
alias gpr="git pull --rebase"
alias fuckshitup="git branch --merged develop | grep -v master | grep -v develop | xargs --no-run-if-empty git branch -d"

# Xclip
# usage: echo foo | setclip
#        echo `getclip`
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o";

# Other programs/shortcuts
alias python=python3.5
alias v="nvim"
alias def="/usr/bin/sdcv"
