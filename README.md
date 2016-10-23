# Dotfiles

My dotfiles/configuration files kept in a tidy repo to sync across devices. Includes:

* .bashrc
* .gitconfig
* .profile
* .tmux.conf
* .vim



## Installation

Clone the repo in ~ directory 

```
git clone https://github.com/turnabout/dotfiles
```


Rename the cloned directory `dotfiles` into `.dotfiles`

```
mv dotfiles .dotfiles
```


Run make.sh to correctly set up symlinks for all files

```
.dotfiles/make.sh
```


Optionally run config files as needed

```
# Install necessary packages
.dotfiles/config/initconfig.sh

# Install Sublime Text 3
.dotfiles/config/sublime.sh

# With compiz config, import compiz-unity.profile
```

While running the scripts, if an error about `/var/lib/dpkg/lock` being temporarily unavailable appears, try:
```
ps aux | grep apt
```

Identify a process number that looks stuck and try:
```
kill -9 processnumber
```

Then launch the script again and it should be fine.

Also includes a `bin` folder containing executable bash commands, for more funtimes.