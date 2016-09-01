#!/usr/bin/python
import sys
if len(sys.argv) != 3:
    print('Usage: ./echon.py <number of lines> <string>')
    exit()
try:
    for i in range(int(sys.argv[1])):
        print(sys.argv[2])
except ValueError:
    print('./echon.py: argument 1 must be a non-negative integer')
    exit()
