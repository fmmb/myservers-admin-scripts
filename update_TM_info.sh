#!/bin/bash

user=$1
if [ -z "$user" ]; then
  echo "Please specify a user"
  exit 1
fi

mkdir -p /home/$user/TM
chown $user /home/$user/TM 

echo "##### UPDATING /home/$user/TM... "
rsync --dry-run --exclude=".*" --update --delete -hratzv --links ~fmmb/TM/ /home/$user/TM
echo -n "##### <ENTER> to proceed..."
read ok
if [ -z "$ok" ]; then
  rsync --exclude=".*" --update --delete -hratzv --links ~fmmb/TM/ /home/$user/TM
  find /home/$user/TM -exec chown ${user}:tm2020 {} \;
else
  echo "##### Skipping /home/$user/TM..."
fi


