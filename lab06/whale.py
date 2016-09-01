#!/usr/bin/python3
import re
import sys
i = 0
j = 0
while 1:
    try:
        x = str(input())
        if sys.argv[1] in x:
            number = x.split(' ')
            i += int(number[0])
            j += 1
    except EOFError:
        print("{} observations: {} pods, {} individuals".format(sys.argv[1],j,i))
        exit()
