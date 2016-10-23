################################
# sublime.sh
# Install Sublime Text 3
################################

# Variables
st3installedpackagesfolder="/home/${USER}/.config/sublime-text-3/Installed Packages/"
st3packagesfolder="/home/${USER}/.config/sublime-text-3/Packages/"

# Install
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

# Open it once to generate config files
subl

# Enable package control
wget https://packagecontrol.io/Package%20Control.sublime-package -P "${st3installedpackagesfolder}"

# Clone config files git repo
cd "${st3packagesfolder}"
rm -r -f User

git clone https://github.com/turnabout/sublime.git User

cd ~