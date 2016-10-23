################################
# sublime.sh
# Install Sublime Text 3
################################

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer


st3packagesdir="/home/${USER}/.config/sublime-text-3/Packages/"

cd "${st3packagesdir}"
rm -r -f User

git clone https://github.com/turnabout/sublime.git User

cd ~