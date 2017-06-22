#!/bin/sh

while read x
do
	echo $x | tr '[0-4]' '<' | tr '[6-9]' '>'
done

