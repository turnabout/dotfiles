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



## Additional scripts/configs

In the `config` folder are some scripts/config files for installing my prefered development environment.



### initconfig.sh

*Installs packages that are written down in `packages.list`
*Installs terminal color scheme
*Adds other preferred configurations



### sublime.sh

Installs Sublime Text 3.
```
.dotfiles/config/sublime.sh
```
Once finished, open Sublime and CTRL+Shift+P > Install Package Control



### compiz-unity.profile

Profile for prefered compiz-config configurations. Can be imported from compiz-config.