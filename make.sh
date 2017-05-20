################################################################################
# make.sh
# Creates symlinks from the home directory 
# to any desired dotfiles in ~/.dotfiles
################################################################################


# Variables
dir=~/.dotfiles             # Dotfiles directory
olddir=~/dotfiles_old       # Old dotfiles backup directory
files=".bash_logout .bashrc .gitconfig .profile .tmux.conf .vim bin"

# Move dotfiles to .dotfiles hidden folder
# mv ~/.dotfiles $dir

mkdir -p $olddir
cd $dir

# Move any existing dotfiles in homedir to dotfiles old dir, create symlinks
for file in $files; do
  mv ~/$file ~/dotfiles_old/ 2>/dev/null
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/$file
done

# Create directories for neovim init file & create symlink
mkdir -p ~/.config/nvim
ln $dir/.vim/nvimrc ~/.config/nvim/init.vim
