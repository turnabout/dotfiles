################################
# make.sh
# Creates symlinks from the home directory 
# to any desired dotfiles in ~/.dotfiles
################################

# Variables
dir=~/.dotfiles             # Dotfiles directory
olddir=~/dotfiles_old       # Old dotfiles backup directory
files=".bashrc .vim .profile bin"

# Move dotfiles to .dotfiles hidden folder
# mv ~/.dotfiles $dir

mkdir -p $olddir
cd $dir

# Move any existing dotfiles in homedir to dotfiles_old directory, then create the symlinks
for file in $files; do
  mv ~/$file ~/dotfiles_old/ 2>/dev/null
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/$file
done