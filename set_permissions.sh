#!/bin/bash

data=$(date +"%Y-%m-%d-%H-%M")
changes=$(ls -ald /home/a[0-9]* | grep -v "drwx------" | wc -l)
echo "$changes permissions were changed"

if [ $changes -gt 0 ]; then
  ls -ald /home/a[0-9]* | grep -v "drwx------" 
  echo -n "Do you want to reset all permissions ? (y/n)"
  read opcao
  if [ "$opcao" = "y" ]; then
    sudo chmod 700 /home/a[0-9]*
  fi
fi
