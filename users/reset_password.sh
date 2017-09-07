#!/bin/zsh

if [ $# -ne 2 ]; then
  echo "please provide the email and the username"
  exit 1
fi

email=$1
username=$2

match=$(grep -c "^$username:" /etc/passwd )
if [ $match -ne 0 ]; then
    name=$( cat /etc/passwd| grep "^$username:" | awk -F '[:,]' '{print $5}')
    password=$(./create_random_passwd.py)
	echo "($password)"
    echo $password | awk '{print $0; print $0}' | passwd $username
    ./envia_mail.py "$name" "$email" "$username" "$password"
else
   echo "Skipping: user $username does not exists"
fi

