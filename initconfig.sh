################################
# initconfig.sh
# Installs & configures values for 
# my prefered work environment
################################

# Install all packages written in 'packages.list'
cat packages.list | xargs sudo apt-get -y install

