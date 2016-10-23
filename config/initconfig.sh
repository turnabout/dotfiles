################################
# initconfig.sh
# Installs & configures values for 
# my prefered work environment
################################

# Variables
dir=~/.dotfiles

# Install all packages written in 'packages.list'
sudo apt-get update
cat packages.list | xargs sudo apt-get -y install

# Install gnome terminal color scheme (from https://github.com/Mayccoll/Gogh/blob/master/content/themes.md#monokai-dark)
wget -O xt http://git.io/v3DBO && chmod +x xt && ./xt && rm xt

# Set Additional Workspaces
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 3
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 3