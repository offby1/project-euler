#!/usr/bin/env python

the_triangle = []

with open("67.txt") as inf:
    for line in inf:
        numbers = [int(thing) for thing in line.split()]
        the_triangle.append(numbers)

for rownum, row in enumerate(the_triangle[1:]):
    child_row = the_triangle[rownum]

    for colnum in range(len(row)):
        left_child = child_row[colnum]
        right_child = child_row[colnum + 1]
        row[colnum] += max(left_child, right_child)

print(the_triangle[-1][0])
