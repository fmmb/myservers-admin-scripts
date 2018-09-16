#!/bin/bash

data=$(date +"%Y-%m-%d-%H-%M")

changes=$(ls -ald /home/a[0-9]* | grep -v "drwx--x--x" | wc -l)
if [ $changes -gt 0 ]; then
  echo "$changes permissions were changed"
  ls -ald /home/a[0-9]* | grep -v "drwx--x--x" 
  echo -n "Do you want to reset all permissions ? (y/n)"
  read opcao
  if [ "$opcao" = "y" ]; then
    sudo chmod 711 /home/a[0-9]*
  fi
fi
