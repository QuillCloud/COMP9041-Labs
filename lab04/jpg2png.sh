#!/bin/sh
for filename in *.jpg
do
    a=`basename "$filename" .jpg`
    if [ -f "$a.png" ];then
	echo "$a.png already exits"
	exit 1
    else
	echo `convert "$a.jpg" "$a.png" && rm "$a.jpg"` >/dev/null
    fi
done