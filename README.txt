     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
                                   

Usage
--------------------------------------------------------------------------------
    cd ~
    git clone https://github.com/turnabout/dotfiles
    mv dotfiles .dotfiles
    ~/.dotfiles/make.sh

Notes
--------------------------------------------------------------------------------
Used to generate the header titles::
    figlet -f standard (title)

To use bash aliases auto-completion:
1. Make sure `bash-completion` is installed (`apt install bash-completion`)
2. Add the new alias like normal to .bash_aliases (or .bash_git, or any other file)
3. Register the new alias at the bottom of .bash_completion like this: `complete -F _complete_alias foo`

More information: https://github.com/cykerway/complete-alias
