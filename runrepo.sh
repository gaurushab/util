#!/usr/bin/env bash
cd ~
sudo dnf install git -y
sudo mkdir /secrets
sudo mount /dev/sdb1 /secrets
cp /secrets/git-credentials ~/.git-credentials
git clone https://github.com/gaurushab/$1.git
cd $1
chmod +x *.sh
bash main.sh
