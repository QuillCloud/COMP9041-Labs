#!/bin/sh

for filename in $@;
do
    a=`ls -l $filename | sed 's/\s\+/ /g' | cut -d" " -f6,7,8`
    `convert -gravity south -pointsize 36 -draw "text 0,10 '$a'" $filename $filename`
    `touch -d"$a" $filename`
done