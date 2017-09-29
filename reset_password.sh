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
    grp=$(cat /etc/group | grep "$(cat /etc/passwd | grep "^$username" | cut -d':' -f4)" | cut -d':' -f1 | head -1)
    if [ -f mensagem.$grp.txt ]; then
       echo "Sending the content of mensagem.$grp.txt"
    else
      echo "error: File not found: mensagem.$grp.txt"
      exit 1
    fi
    password=$(./create_random_passwd.py)
	echo "($password)"
    echo $password | awk '{print $0; print $0}' | passwd $username
    cat mensagem.$grp.txt | sed "s/#NAME#/$name/g;s/#USERNAME#/$username/g;s/#PASSWORD#/$password/g" | ./envia_mail.py "$email"
else
   echo "Skipping: user $username does not exists"
fi

