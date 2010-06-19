#!/usr/bin/env python

the_triangle = []

with open('triangle.txt') as inf:
    for line in inf:
        numbers = map(int, line.split())
        the_triangle.insert(0, numbers)

for rownum, row in enumerate(the_triangle[1:]):
    child_row = the_triangle[rownum]

    for colnum, elt in enumerate(row):
        left_child  = child_row[colnum]
        right_child = child_row[colnum + 1]
        row[colnum] += max(left_child, right_child)

print(the_triangle[-1][0])
