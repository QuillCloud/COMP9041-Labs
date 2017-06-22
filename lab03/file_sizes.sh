#!/bin/bash
s="Small files:"
m="Medium-sized files:"
l="Large files:"
for i in *
do
	a=`cat $i | wc -l`
	if [[ "$a" -lt 10 ]]
	then
		s=$s' '$i
	elif [[ "$a" -lt 100 ]]
	then
		m=$m' '$i
	else
		l=$l' '$i
	fi
done
echo $s
echo $m
echo $l
