#!/usr/bin/python3
import sys
for i in range(1,len(sys.argv)):
    y=[]
    x=0
    f = open(sys.argv[i],'r')
    line = f.readline()
    while line:
        y.append(line)
        x = x + 1
        line = f.readline()
    if (x < 10):
        for j in range(x):
            print(y[j], end = '')
    if (x >= 10):
        a = x - 10
        for j in range(a,x):
            print(y[j], end = '')
