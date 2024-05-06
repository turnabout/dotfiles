#                                                   
#                 █                           █     
#   ▄▄▄▄▄   ▄▄▄   █   ▄   ▄▄▄           ▄▄▄   █ ▄▄  
#   █ █ █  ▀   █  █ ▄▀   █▀  █         █   ▀  █▀  █ 
#   █ █ █  ▄▀▀▀█  █▀█    █▀▀▀▀          ▀▀▀▄  █   █ 
#   █ █ █  ▀▄▄▀█  █  ▀▄  ▀█▄▄▀    █    ▀▄▄▄▀  █   █ 
#                                                   
                                                 
# Creates dotfiles repo symlinks


# Old dotfiles backup directory
olddir=~/dotfiles_old

# Dotfiles directory
dir=~/.dotfiles

# All files to symlink
files="
.bash_logout 
.bashrc 
.gitconfig 
.tmux.conf 
.vim 
.sxhkdrc 
.bash_aliases 
.bash_functions
.bash_git
.bash_completion
.ideavimrc
bin
"

mkdir -p $olddir
cd $dir

# Move any existing dotfiles in homedir to dotfiles old dir, create symlinks
for file in $files; do
  mv ~/$file ~/dotfiles_old/ 2>/dev/null
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/$file
done

# Create directories for neovim init file & symlink
mkdir -p ~/.config/nvim
ln -s $dir/.vim/nvimrc ~/.config/nvim/init.vim

# Symlink files from additional directories
ln -s $dir/.i3.config ~/.config/i3/config
ln -s $dir/.i3.gostatus.yml ~/.config/i3/gostatus.yml
