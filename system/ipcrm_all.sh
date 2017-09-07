#!/bin/zsh
ipcs | grep -E "^\-|^0x"
if [ $# -eq 1 ]; then
  owner=$1
  for i in $(ipcs -q| grep "0x.* $owner" | cut -d' ' -f1); do ipcrm -Q $i; done
  for i in $(ipcs -m| grep "0x.* $owner" | cut -d' ' -f1); do ipcrm -M $i; done
  for i in $(ipcs -s| grep "0x.* $owner" | cut -d' ' -f1); do ipcrm -S $i; done
  echo "After....."
  ipcs | grep -E "^\-|^0x"
else
  echo ""
  echo "please specify a username. Examples: fmmb, a[0-9]"
fi
