#!/usr/bin/env bash

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

sudo dnf install epel-release -y
sudo dnf --refresh update -y

sudo dnf install openssh openssh-server openssh-clients -y
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo mkdir /secrets
sudo mount /dev/sdb1 /secrets

sudo dnf install git -y
git config --global credential.helper 'store --file /secrets/git-credentials'

cd ~
git clone https://github.com/gaurushab/$1.git
cd $1
chmod +x *.sh
bash main.sh
