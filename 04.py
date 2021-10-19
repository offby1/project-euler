# https://projecteuler.net/problem=4

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

import itertools
import operator

three_digit_numbers = range(100, 1000)
products = ((a * b, a, b) for a, b in itertools.product(three_digit_numbers, three_digit_numbers))

def is_panindromic(n):
    n = str(n)
    return n == ''.join(reversed(n))

palindromic_products = (p for p in products if is_panindromic(p[0]))

print(max(palindromic_products, key=operator.itemgetter(0)))
# >>> 906609
