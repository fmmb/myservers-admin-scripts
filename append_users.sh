#!/bin/zsh

if [ $# -lt 1 ]; then
  echo "please provide the filename containing the new users"
  exit 1
elif [ ! -f "$1" ]; then
  echo "The filename containing the new users does not exist"
  exit 2
fi
newusers=$1

# Default group
group=so
#group=tm
#group=pcl
#group=soca
if [ $# -eq 2 ]; then
  group=$2
fi

if [ ! -f mensagem.$group.txt ]; then
   echo "error: File not found mensagem.$group.txt"
   exit 3
fi

echo "Ok, Ready to append additional students"

cat $newusers | iconv -f UTF-8 -t 'ASCII//TRANSLIT' | tr -d "'" | while read line; do
  username=a$( echo "$line" | awk -F'\t' '{print $1}')
  match=$(grep -c "^$username" /etc/passwd )
  if [ $match -ne 0 ]; then
     echo "skipping $username, user already exists"
  else
    nome=$( echo "$line" | awk -F'\t' '{print $2}')
    email=$( echo "$line" | awk -F'\t' '{print $3}')
    adduser --ingroup $group --gecos "$nome" --disabled-login $username
    chmod 700 /home/$username
    ./reset_password.sh $email $username

    if [ $group = "tm" ]; then
      adduser $username jupyterhub
    fi
  fi
done
