#!/usr/bin/python3
import sys
import operator
from collections import deque
import copy
lines = []
s = sys.argv[1]
d = sys.argv[2]
while True:
    line = sys.stdin.readline()
    if line:
        lines.append(line)
    else:
        break

maps = {}
for i in lines:
    element = i.split()
    if element[0] not in maps:
        maps[element[0]] = {}
    if element[1] not in maps:
        maps[element[1]] = {}
    maps[element[0]][element[1]] = int(element[2])
    maps[element[1]][element[0]] = int(element[2])
check = set()
go = deque()
fp = {}
fp[s] = {}
fp[s]['p'] = [s]
fp[s]['l'] = 0
go.append(s)
while len(go) != 0:
    cur = go.popleft()
    check.add(cur)
    for i in maps[cur]:
        if i in check:
            continue
        if i not in fp:
            fp[i] = {}
            fp[i]['p'] = copy.copy(fp[cur]['p'])
            fp[i]['p'].append(i)
            fp[i]['l'] = fp[cur]['l'] + maps[cur][i]
        if i in fp:
            com = fp[i]['l'] - (fp[cur]['l'] + maps[cur][i])
            if com > 0:
                fp[i]['p'] = copy.copy(fp[cur]['p'])
                fp[i]['p'].append(i)
                fp[i]['l'] = fp[cur]['l'] + maps[cur][i]
        sorted_d = sorted(maps[cur].items(), key=operator.itemgetter(1))
        for j in sorted_d:
            go.append(j[0])
result = ''
for i in fp[d]['p']:
    result = result + ' ' + i
print("Shortest route is length = {}:{}.".format(fp[d]['l'], result))
