cd ~

# install git and essentials
sudo apt-get install -y git curl
sudo apt-get install -y emacs
sudo apt-get install -y python3-pip python3-dev python-virtualenv
git config --global user.name "Brian Cui"
git config --global user.email "brian.cui@live.com"

# install node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# update packages
sudo apt-get update -y

# setup git ssh keys
ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
read -p "Press [Enter] to continue"

# setup dotfiles
git clone git@github.com:theBrianCui/dotfiles.git
cd dotfiles
./setup.sh
