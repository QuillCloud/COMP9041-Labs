#!/bin/bash
a=`echo $1 | cut -c1`
x=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2016/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$a"|grep $1|grep "http:"|cat -A`
y=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2016/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$a"|grep $1|grep "http:"|cat -A`
list=`echo "$x"|cut -d'/' -f7|cut -d'.' -f1`
echo "$x"|cat|while read i
do	
	name1=`echo "$i"|cut -d'>' -f3|cut -d'<' -f1`
	id1=`echo -n "$i"|cut -d'/' -f7|cut -d'.' -f1`
     	echo "$id1" "$name1"
done > "$$"
echo "$y"|cat|while read j
do
	name2=`echo "$j"|cut -d'>' -f3|cut -d'<' -f1`
	id2=`echo -n "$j"|cut -d'/' -f7|cut -d'.' -f1`
	echo "$id2" "$name2"
done >> "$$"
cat "$$" | sort | uniq -d
