#!/usr/bin/env bash
sudo mkdir /secrets
sudo mount /dev/sdb1 /secrets
cp /secrets/git-credentials ~/.git-credentials
sudo apt install git -y
cd ~
git clone https://github.com/gaurushab/$1.git
cd $1
chmod +x *.sh
bash main.sh
