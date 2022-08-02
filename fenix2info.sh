#!/bin/bash
sed -E 's/ +\t/\t/g;s/\t +/\t/g;s/ [^\t]+ / /g' | awk -F'\t' '{printf("a%s\t%s\t%s\n", $1, $7, $10)}' | iconv -t "ascii//TRANSLIT" | sed -E 's/\W+\t|\t\W+/\t/g'

# Check existent users
# grep -E "$(cat /etc/passwd | awk -F':' /^a[0-9]/'{printf("%s|",$1)}' | sed 's/|$//')"
# cat /etc/passwd | grep -E $(cat users-already-in-passwd | awk '{print $1}' | tr '\n' '|' | sed 's/|$//')
