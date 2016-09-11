#!/usr/bin/python3
import sys
import re
w_count = 0
for line in sys.stdin:
    line = re.sub(r'[^A-Za-z]',' ',line)
    line = re.sub(r'\'s',' s',line)
    word = re.split(r'\s+',line.lower())
    for x in word:
        if x == sys.argv[1].lower():
           w_count += 1
print("{} occurred {} times".format(sys.argv[1].lower(),w_count)) 
