#!/bin/zsh

DDIR=/backups
if [ ! -d $DDIR ]; then
   echo "Destination directory does not exist. Please create it using admin permissions and make sure to protect it"
  exit 2
fi

backall() {
    BDIR=$1
    PREFIX=$2
    SKIPEXP=$3
    for i in $BDIR/*; do
        skip=$( echo $i | grep -E -c $SKIPEXP )
        if [ "$skip" -gt 0 ]; then
                echo "Skipping $i"
        else
                echo "Backing up $i to $PREFIX.${i:t}.tar.gz"
                tar zcf $PREFIX.${i:t}.tar.gz $i
        fi
    done
}


backdir() {
    BDIR=$1
    PREFIX=$2
    SKIPEXP=$3
    for i in $BDIR; do
        skip=$( echo $i | grep -E -c $SKIPEXP )
        if [ "$skip" -gt 0 ]; then
                echo "Skipping $i"
        else
                echo "Backing up $i to $PREFIX${i:t}.tar.gz"
                tar zcf $PREFIX${i:t}.tar.gz $i
        fi
    done
}


data=$(date +"%Y-%m-%d-%H-%M")
mkdir $DDIR/$data
cd $DDIR/$data

backall "/home" "$DDIR/$data/home" "/(lost\+found|ariele|backups|home.old|archived)$"
backdir "/etc" "$DDIR/$data/" "/(lost\+found)$"
backdir "/var/www" "$DDIR/$data/var." "/(lost\+found|packages)$"
