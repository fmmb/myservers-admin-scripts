#!/bin/bash

if [ $# -lt 1 ]; then
  echo "$0 username [email]"
  exit 1
elif [ $# -eq 2 ]; then
  email=$2
fi
username=$1

match=$(grep -c "^$username:" /etc/passwd )
if [ $match -ne 0 ]; then
    name=$( cat /etc/passwd| grep "^$username:" | awk -F '[:,]' '{print $5}')
    if [ -z "$email" ]; then
       email=$( cat /etc/passwd| grep "^$username:" | awk -F '[:,]' '{print $6}')
    fi
    group=$(cat /etc/group | grep -v "jupyterhub" | grep -w "$username" | head -1 | cut -d':' -f1)
    if [ ! -f messages.`hostname`/$group.txt ]; then
      echo "error: File not found: messages.`hostname`/$group.txt"
      exit 1
    fi
    password=$(./create_random_passwd.py)
    #echo "($password)"
    echo $password | awk '{print $0; print $0}' | passwd $username &> /dev/null
	if [ $? -ne 0 ]; then
		echo "Error: Could not change the password"
		exit 1
	fi
    echo "Sending the content of messages.`hostname`/$group.txt"
    cat messages.`hostname`/$group.txt | sed "s/#NAME#/$name/g;s/#USERNAME#/$username/g;s/#PASSWORD#/$password/g" | ./envia_mail.py "$email"
    #if [ -n "$admin_email_pass" ]; then
    #else
    #  echo "cat messages.`hostname`/$group.txt | sed \"s/#NAME#/$name/g;s/#USERNAME#/$username/g;s/#PASSWORD#/$password/g\" | 
	#     mailx -r \"fernando.batista@iscte-iul.pt (Fernando Batista)\" -s \"Iscte: acesso ao servidor tm.iscte.me\" \"$email\"" >> commands-to-use-in-the-smtp-server.sh
    #fi
else
   echo "Skipping: user $username does not exist"
fi
