#!/usr/bin/python
import re
while 1:
    try: 
        x = str(raw_input())
        x = re.sub('[0-4]','<',x)
        x = re.sub('[6-9]','>',x)
        print(x)
    except EOFError:
        exit()
