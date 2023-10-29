#!/usr/bin/env bash

export REPONAME=$1

#initilize system
cd ~
wget https://raw.githubusercontent.com/gaurushab/util/main/sysinit.sh
bash sysinit.sh

#clone repo from github
cd ~
sudo mkdir /secrets
sudo mount /dev/sdb1 /secrets -o umask=0000
sudo dnf install git -y
git config --global credential.helper 'store --file /secrets/github'
git clone https://github.com/gaurushab/$REPONAME.git
sudo umount -l /dev/sdb1

#execute the repo
cd $REPONAME
export BASEDIR=$PWD
echo 'export BASEDIR='$BASEDIR >> ~/.bashrc
chmod +x *.sh
echo "starting repo execution at "$(date)
bash main.sh > runrepo.log
echo "completed repo execution at "$(date)


