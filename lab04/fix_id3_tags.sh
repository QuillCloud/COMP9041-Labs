#!/bin/sh
d=`echo "$1" | cut -d'/' -f1`
cd "$d"
for p in "$@"
do
    dd=`echo "$p" | cut -d'/' -f2`
    cd "$dd"
    album=`echo "$dd" | cut -d"/" -f1`
    year=`echo "$album" | cut -d',' -f2 | sed 's/ //g'`
    echo $album
    echo $year
    id3 -A "$album" *
    id3 -y "$year" *
    for mp in *;
    do
	s=`echo "$mp" | sed 's/.mp3//g' | sed 's/ - /^/g'`
	track=`echo "$s" | cut -d'^' -f1`
	title=`echo "$s" | cut -d'^' -f2`
	artist=`echo "$s" | cut -d'^' -f3`
	id3 -T "$track" "$mp"
	id3 -t "$title" "$mp"
	id3 -a "$artist" "$mp"
    done
    cd ..
done >/dev/null