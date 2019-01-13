#!/bin/bash
show -e
echo "Running quickstart script..."
cd ~
clear

WINDOWS=0
if [ -e "/mnt/c/Windows" ]
then
  WINDOWS=1
fi

if [ "$WINDOWS" -eq 1 ]
then
  echo "Using WSL"
else
  echo "Not using WSL"
fi

# install git and essentials
sudo apt-get install -y git
sudo apt-get install -y curl
sudo apt-get install -y dos2unix
sudo apt-get install -y emacs
sudo apt-get install -y python-pip python-dev python-virtualenv
sudo apt-get install -y python3-pip python3-dev python-virtualenv
sudo apt-get install -y default-jre default-jdk
sudo apt-get install -y gcc
sudo apt-get install -y clang
sudo apt-get install -y gdebi-core
sudo apt-get install -y gcp tree

if [ "$WINDOWS" -eq 0 ]
then
  sudo apt-get install -y xclip
fi

# configure git
email="brian.cui"
domain="@live.com"
git config --global user.name "Brian Cui"
git config --global user.email "$email$domain"

# install node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# update packages
sudo apt-get update -y

# setup git ssh keys
echo "Creating SSH key..."
ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
echo ""
hostname
echo ""
cat ~/.ssh/id_rsa.pub
echo ""

if [ "$WINDOWS" -eq 1 ]
then
  cat ~/.ssh/id_rsa.pub | clip.exe
else
  cat ~/.ssh/id_rsa.pub | xclip -selection c
fi
read -p "SSH key copied to clipboard. Press [Enter] to continue"

# setup dotfiles
git clone git@github.com:theBrianCui/dotfiles.git
cd dotfiles
./setup.sh
