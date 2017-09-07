#!/bin/zsh

DDIR=/home/admin/Backups
if [ ! -d $DDIR ]; then
   echo "Destination directory does not exist. Please create it using admin permissions and make sure to protect it"
  exit 2
fi

data=$(date +"%Y-%m-%d-%H-%M")
mkdir $DIR/$data
cd $DDIR/$data

for i in /home/a[0-9]*; do
  echo "Backing up ${i:t}"
  tar zcf ${i:t}.tar.gz $i
done
