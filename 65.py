import itertools

from sympy.ntheory.continued_fraction import continued_fraction_convergents

# e = [2; 1, 2, 1, 1, 4, 1, 1, 6, 1, ... , 1, 2k, 1, ...]


def continued_fraction_for_e():
    yield 2
    yield 1
    for k in itertools.count(1):
        yield 2 * k
        yield 1
        yield 1


def tt(generator):
    return list(itertools.islice(generator, 100))


if __name__ == "__main__":
    approx_expansion = tt(continued_fraction_for_e())

    import pprint

    convergents = list(continued_fraction_convergents(approx_expansion))
    pprint.pprint(list(enumerate(convergents)))

    n = convergents[-1].numerator
    print(f"That numerator again: {n}")
    digit_sum = sum([int(c) for c in str(n)])
    print(f"{digit_sum=}")
