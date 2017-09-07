#!/bin/zsh
minproc=9
mincpu=20.0
minminutes=2
maxproc=32
opt="$1"    # kill, fkill (forced kill)
date

echo "Selecting candidate problems: multiple processes with the same name"
ps -eo user,comm,args --no-headers |grep -E "^a[0-9]{5}\>" | sort | uniq -c | sort -rn | 
  awk -v minproc=$minproc '$1>=minproc{print $0}' | while read line; do
  echo "$line"
  user=$(echo $line | awk '{print $2}')
  pname=$(echo $line | awk '{print $3}')
  if [ "$opt" = "kill" ]; then
    echo "Killing processes from <$user> with name <$pname> ..."
    pkill -u "$user" "$pname"
  elif [ "$opt" = "fkill" ]; then
    echo "Killing processes from <$user> ..."
    pkill -KILL -u "$user"
  fi
done

echo "Selecting candidate problems based on the CPU usage"
ps -eo user,pid,pcpu,cputime,comm,args --no-headers |grep -E "^a[0-9]{5}\>" | awk -v mincpu=$mincpu '$3>mincpu{print $0}' | while read line; do
  echo $line
  user=$(echo $line | awk '{print $1}')
  pid=$(echo $line | awk '{print $2}')
  minutes=$(echo $line | awk '{print $4}' | awk -F':' '{print $2}')
  if [ "$opt" = "kill" ] && [ "$minutes" -ge $minminutes ]; then
    echo "Killing process <$pid> from <$user> ..."
    kill $pid
  elif [ "$opt" = "fkill" ] && [ "$minutes" -ge "$minminutes" ]; then
    echo "Killing process <$pid> from <$user> ..."
    kill -9 $pid
  fi
done

echo "Showing users that are using many processes"
ps uax | awk '/^a[0-9]/{print $1}' | sort | uniq -c | sort -rg | 
  awk -v maxproc=$maxproc '{if($1>maxproc)print $2, "is using", $1, "processes"}'
if  [ "$opt" = "kill" ]; then
  ps uax | awk '/^a[0-9]/{print $1}' | sort | uniq -c | sort -rg | awk -v maxproc=$maxproc '{if($1>maxproc)print $2}' | 
  while read u; do
    killall -u $u
  done
fi
