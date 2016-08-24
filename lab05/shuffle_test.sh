#!/bin/sh
output=`i=0;while test $i -lt 5; do echo $i; i=$((i + 1)); done|./shuffle.pl`;
b=`echo "$output" | egrep '^[0-4]$'`
a=`echo "$output" | sort | uniq | wc -l`;
if (( $a!=5 ));then
echo 'Test Fail';
else echo 'Test passed';
fi