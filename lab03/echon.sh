#!/bin/sh
if [[ $# != 2 ]]
then
	echo "Usage: ./echon.sh <number of lines> <string>"
	exit 1
fi

if [[ $1 =~ [^0-9] ]]
then 
	echo "./echon.sh: argument 1 must be a non-negative integer"
	exit 1
fi

a=1
while [[ "$a" -le "$1" ]]
do
	echo $2
	a=$[$a+1]
done
