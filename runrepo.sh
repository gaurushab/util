#!/usr/bin/env bash

export REPONAME=$1

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

#disable SELINUX
sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --enable crb
sudo dnf install epel-release -y
sudo dnf --refresh update -y

sudo dnf install openssh openssh-server openssh-clients -y
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo mkdir /secrets
sudo mount /dev/sdb1 /secrets -o umask=0000

sudo dnf install git -y
git config --global credential.helper 'store --file /secrets/git-credentials'

cd ~
echo "Cloning repo."
git clone https://github.com/gaurushab/$REPONAME.git
cd $REPONAME
chmod +x *.sh
echo "Running repo. Writing output to ~/$REPONAME.log"
bash main.sh > ~/$REPONAME.log
echo "Done! Written output to ~/$REPONAME.log"
