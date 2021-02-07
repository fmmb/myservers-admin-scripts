#!/bin/bash
sed -E 's/ +\t/\t/g;s/\t +/\t/g;s/ [^\t]+ / /g' | awk -F'\t' '{printf("a%s\t%s\t%s\n", $1, $7, $10)}' | iconv -t "ascii//TRANSLIT"
