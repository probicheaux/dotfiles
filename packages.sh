#!/bin/bash
sudo apt-get update
sudo apt-get install curl
sudo apt-get install neovim
sudo apt-get install ripgrep
sudo apt install fzf
brew install gh
sudo sed -i '/\/usr\/.crates2.json/d' /var/lib/dpkg/info/ripgrep.list
sudo apt install bat
sudo ln -s batcat /usr/bin/bat
