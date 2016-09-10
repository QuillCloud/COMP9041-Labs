#!/usr/bin/python3
import sys
import re
result = {}
name=[]
try:
    while 1:
        x = str(input())
        x = x.lower()
        number = x.split(' ')
        x = re.sub('^\d+|\s+|^\s+|\s$|s$','',x)
        if x in result:
            result[x][0] += int(number[0])
            result[x][1] += 1
        else:
            result[x] = []
            result[x].append(int(number[0]))
            result[x].append(1)
            name.append(x)
except EOFError:
    name = sorted(name)
    for x in name:
        print('{} observations: {} pods, {} individuals'.format(x,result[x][1],result[x][0]))
    exit()
        
