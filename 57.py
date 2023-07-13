import fractions

import more_itertools


def next_wozzit(prev):
    return 1 / (prev + 2)


i = more_itertools.iterate(next_wozzit, fractions.Fraction(0))
gotcha = 0
for _ in range(1_000):
    wat = 1 + next(i)
    if len(str(wat.numerator)) > len(str(wat.denominator)):
        gotcha += 1
print(gotcha)
