import itertools

import sympy                    # pip install sympy
import tqdm                     # pip install tqdm

abundant_numbers = set()
for n in range(28213):
    if sum(sympy.proper_divisors(n)) > n:
        abundant_numbers.add(n)

sums_of_two_abdundant_numbers = set()
for a1, a2 in tqdm.tqdm(
    itertools.product(abundant_numbers, abundant_numbers),
    total=pow(len(abundant_numbers), 2),
):
    sums_of_two_abdundant_numbers.add(a1 + a2)

numbers_that_cannot_be_yadda_yadda = set(range(28213)) - sums_of_two_abdundant_numbers

print(sum(numbers_that_cannot_be_yadda_yadda))
