from sympy import isprime, nextprime


def prime_sums_starting_at(p):
    if not isprime(p):
        p = nextprime(p)

    sum_us = [p]
    while True:
        s = sum(sum_us)
        if s >= 1_000_000:
            break
        if isprime(s):
            yield s, len(sum_us)
        p = nextprime(p)
        sum_us.append(p)


def solution_starting_at(p):
    ps = prime_sums_starting_at(p)
    return max(ps, key=lambda t: t[1])


best_so_far = None
for i in range(1_000_000):

    this = solution_starting_at(i)
    if best_so_far is None or this[1] > best_so_far[1]:
        best_so_far = this
        print(best_so_far)
