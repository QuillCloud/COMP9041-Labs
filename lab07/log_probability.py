#!/usr/bin/python3
#!/usr/bin/python3
import sys
import glob
import re
from math import *
r = []
for file in glob.glob("poems/*.txt"):
    r.append(file)
r.sort()
for file in r:
    F = open(file, 'r')
    w_count = 0
    t_count = 0
    line = F.readline()
    while line:
        line = line.lower()
        line = re.sub(r'[^a-z]',' ',line)
        line = re.sub(r'\'s',' s',line)
        words = re.split(r'\s+',line)
        for w in words:
            if w != '':
                t_count +=1
            if w == sys.argv[1].lower():
                w_count += 1
        line = F.readline()
    file = re.sub(r'_',' ',file)
    file = re.sub(r'.txt|poems\/','',file)
    print("log(({:d}+1)/{:6d}) = {:8.4f} {}".format(w_count,t_count,log(w_count+1) - log(t_count),file))
