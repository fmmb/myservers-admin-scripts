#!/bin/bash

user=$1
if [ -z "$user" ]; then
  echo "Please specify a user"
  exit 1
fi

mkdir -p /home/$user/CEB
chown $user /home/$user/CEB 

group=$(groups $user | sed -E 's/ ?: ?/ /' | cut -d' ' -f2)

echo "##### UPDATING /home/$user/CEB ... GROUP: $group"
rsync --dry-run --exclude={".*","tmp"} --update --delete -hratzv --links ~fmmb/repositories/CEB/ /home/$user/CEB
echo -n "##### <ENTER> to proceed..."
read ok
if [ -z "$ok" ]; then
  rsync --exclude={".*","tmp"} --update --delete -hratzv --links ~fmmb/repositories/CEB/ /home/$user/CEB
  find /home/$user/CEB -exec chown ${user}:${group} {} \;
else
  echo "##### Skipping /home/$user/CEB ..."
fi


