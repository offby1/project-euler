# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

import functools
import math


def lcm(a, b):
    return a * b // math.gcd(a, b)


print(functools.reduce(lcm, range(1, 11)))
print(functools.reduce(lcm, range(1, 21)))
