#!/bin/bash

# What I really would like would be to have the user ID iqual to the student ID, but it can't be.
# The file /etc/group is used for knowing who is currently a member of some group
# please unsure that the following groups exist: student

MIN_UID=1100 # Users created in 2020/2021 will start at 1100

if [ $# -lt 1 ]; then
  echo "please provide the filename containing the new users"
  exit 1
elif [ ! -f "$1" ]; then
  echo "The filename containing the new users does not exist"
  exit 2
fi
newusers=$1

# possible groups: tm, pcl, msc, so, soca, tm2020, pcl2020, progcd2020
# group=tm

if [ $# -eq 2 ] && [ $( grep -c "^$2:" /etc/group ) -gt 0 ]; then
  group=$2
else
  echo "ERROR: Please provide the group name. aborting"
  exit 1
fi

if [ ! -f mensagem.$group.txt ]; then
   echo "error: File not found mensagem.$group.txt"
   exit 3
else
   echo "Adding users to the group: $group"
fi

echo -n "Press <enter> to start appending additional students "
read ok

cat $newusers | iconv -f UTF-8 -t 'ASCII//TRANSLIT' | while read line; do
  username=$( echo "$line" | awk -F'\t' '{print $1}')
  match=$(grep -c "^$username" /etc/passwd )
  if [ $match -ne 0 ]; then
     echo "Skipping: user $username already exists"
  else
    nome=$( echo "$line" | awk -F'\t' '{print $2}')
    email=$( echo "$line" | awk -F'\t' '{print $3}')
    adduser --firstuid $MIN_UID --ingroup student --gecos "$nome,,,,$email" --disabled-login $username
    chmod 700 /home/$username

    adduser $username $group
    if [ $( grep -c "^jupyterhub:" /etc/group ) -gt 0 ]; then
      adduser $username jupyterhub
      # Please don't forget to manually add these users later on in the jupyterhub interface
    fi

    ./reset_password.sh $username $email
  fi
done
