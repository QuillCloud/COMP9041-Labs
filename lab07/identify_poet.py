#!/usr/bin/python3
import glob
import sys
import re
import math
total_dic = {}
for file in glob.glob("poems/*.txt"):
    F = open(file, 'r')
    file = re.sub(r'_',' ',file)
    file = re.sub(r'.txt|poems\/','',file)
    total_dic[file] = {}
    t_count = 0
    line = F.readline()
    while line:
        line = line.lower()
        line = re.sub(r'[^a-z]',' ',line)
        words = re.split(r'\s+',line)
        for w in words:
            if w != '':
                t_count += 1
                if w in total_dic[file]:
                    total_dic[file][w] += 1
                else:
                    total_dic[file][w] = 1
        line = F.readline()
    for x in total_dic[file]:
        total_dic[file][x] = math.log(total_dic[file][x] + 1) - math.log(t_count)
    total_dic[file][0] = math.log(1) - math.log(t_count)

for i in range(1,len(sys.argv)):
    dic = {}
    F = open(sys.argv[i], 'r')
    line  = F.readline()
    while line:
        line = line.lower()
        line = re.sub(r'[^a-z]',' ',line)
        words = re.split(r'\s+',line)
        for w in words:
            if w != '':
                if w in dic:
                    dic[w] += 1
                else:
                    dic[w] = 1
        line = F.readline()
    h_number = ''
    h_name = ''
    for y in total_dic:
        c = 0
        for x in dic:
            if x in total_dic[y]:
                c += total_dic[y][x]*dic[x]
            else:
                c += total_dic[y][0]*dic[x]
        if h_number == '' or h_number < c:
            h_number = c
            h_name = y
    print("{} most resembles the work of {} (log-probability={:.1f})".format(sys.argv[i], h_name, h_number))

