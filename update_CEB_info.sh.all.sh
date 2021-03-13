#!/bin/zsh

./update_CEB_info.sh fmmb

echo "updating: " $(cat /etc/group | grep "^ceb:" | cut -d":" -f4  |tr ',' ' ')
echo "Press <Enter> to proceed."; read ok
for u in $(cat /etc/group | grep "^ceb:" | cut -d":" -f4  |tr ',' ' ') ; do sudo ./update_CEB_info.sh $u; done
