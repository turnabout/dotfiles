################################
# sublime.sh
# Install Sublime Text 3
################################

# Install
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

# Open it once to generate config files
subl

# Clone config files git repo
cd "/home/${USER}/.config/sublime-text-3/Packages/"
rm -r -f User

git clone https://github.com/turnabout/sublime.git User

cd ~