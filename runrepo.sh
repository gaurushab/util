#!/usr/bin/env bash

export REPONAME=$1

wget https://raw.githubusercontent.com/gaurushab/util/main/sysinit.sh
bash sysinit.sh > sysinit.log

cd ~
git clone https://github.com/gaurushab/$REPONAME.git
cd $REPONAME
export BASEDIR=$PWD
echo 'export BASEDIR='$BASEDIR >> ~/.bashrc
chmod +x *.sh

echo "starting repo execution at "$(date)
bash main.sh > runrepo.log
echo "completed repo execution at "$(date)

# sudo umount -l /dev/sdb1
