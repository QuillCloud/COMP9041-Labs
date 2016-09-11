#!/usr/bin/python3
import sys
import re
count = 0
for line in sys.stdin:
    line = re.sub(r'[^A-Za-z]',' ',line)
    line = re.sub(r'\'s',' s',line)
    word = re.split(r'\s+',line)
    for x in word:
        if x != '':
            count += 1
print("{} words".format(count))
