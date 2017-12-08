#                                                   
#                 █                           █     
#   ▄▄▄▄▄   ▄▄▄   █   ▄   ▄▄▄           ▄▄▄   █ ▄▄  
#   █ █ █  ▀   █  █ ▄▀   █▀  █         █   ▀  █▀  █ 
#   █ █ █  ▄▀▀▀█  █▀█    █▀▀▀▀          ▀▀▀▄  █   █ 
#   █ █ █  ▀▄▄▀█  █  ▀▄  ▀█▄▄▀    █    ▀▄▄▄▀  █   █ 
#                                                   


# Creates dotfiles repo symlinks. Works on Windows 10.

# Symlink function for Windows.
# Ensure git bash is ran as administrator when using.
function winsym() {
  # Format paths for Windows

  # Replace slashes by backslashes
  from=${1//\//\\}
  to=${2//\//\\}

  # Remove leading backslash
  from=${from:1}
  to=${to:1}

  # Replace c\ with c:\
  from=${from//c\\/c:\\}
  to=${to//c\\/c:\\}

  # Call Windows cmd
  if [[ -d "$1" ]]; then
  	cmd <<< "mklink /D \"$to\" \"$from\""
  else
  	cmd <<< "mklink \"$to\" \"$from\""
  fi
}

# Old dotfiles backup directory
olddir=~/dotfiles_old

# Dotfiles directory
dir=~/.dotfiles

# All files to symlink
files="
.bash_logout 
.bashrc
.gitconfig 
.vim
.bash_aliases 
.bash_functions
.bash_profile
.bash_git
.minttyrc
"

mkdir -p $olddir
cd $dir

# Move any existing dotfiles in homedir to dotfiles old dir, create symlinks
for file in $files; do
  mv ~/$file ~/dotfiles_old/ 2>/dev/null
  winsym $dir/$file ~/$file
  # echo "Created symlink to $file in home directory"
done

# Windows specific
winsym $dir/.vim/vimrc ~/.vsvimrc