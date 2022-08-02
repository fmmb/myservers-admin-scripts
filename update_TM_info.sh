#!/bin/bash

user=$1
if [ -z "$user" ]; then
  echo "Please specify a user"
  exit 1
fi

mkdir -p /home/$user/TM
chown $user /home/$user/TM 

group=$(groups $user | sed -E 's/ ?: ?/ /' | cut -d' ' -f2)

echo "##### UPDATING /home/$user/TM ... GROUP: $group"
rsync --dry-run --exclude={".*","tmp"} --update --delete -hratzv --links ~fmmb/repositories/TM/ /home/$user/TM
echo -n "##### <ENTER> to proceed..."
read ok
if [ -z "$ok" ]; then
  rsync --exclude={".*","tmp"} --update --delete -hratzv --links ~fmmb/repositories/TM/ /home/$user/TM
  find /home/$user/TM -exec chown ${user}:${group} {} \;
else
  echo "##### Skipping /home/$user/TM ..."
fi


