#!/usr/bin/python3
import subprocess
import re
import sys
url = sys.argv[1]
mode = 1
if url == '-f':
    url = sys.argv[2]
    mode = 2
webpage = subprocess.check_output(["wget", "-q", "-O-", url], universal_newlines=True)
line = webpage.split('\n')
dic = {}
triger = 0
s = ''
for i in line:
    if re.search(r'<.*>',i):
        for j in i:
            if j == '<':
                triger = 1
                s = ''
            elif j == '>':
                triger = 0
                if not s[0].isalpha():
                    #if s[0] == '/':
                       # if ' ' in s:
                         #   get = s.split(' ')
                         #   s = get[0]
                        #if s in dic:
                          #  dic[s] += 1
                        #else:
                        #    dic[s] = 1
                    #else:
                    continue
                else:
                    if ' ' in s:
                        get = s.split(' ')
                        s = get[0]
                    if s in dic:
                            dic[s] += 1
                    else:
                            dic[s] = 1
            elif triger == 1:
                s += j.lower()
if mode == 1:
    for j in sorted(dic):
        print('{} {}'.format(j, dic[j]))
else:
    for j in sorted(dic, key=dic.get):
        print('{} {}'.format(j, dic[j]))
