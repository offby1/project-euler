import itertools
import concurrent.futures

import sympy


def primes():
    n = 1
    while True:
        yield sympy.prime(n)
        n += 1


def composites():
    n = 2
    p = primes()
    while True:
        np = next(p)
        while n < np:
            yield n
            n += 1
        n += 1                  # skip np


def odd_composites():
    for c in composites():
        if c % 2 == 1:
            yield c


def double_squares():
    n = 1
    while True:
        yield 2 * n * n
        #print(f"{2 * n * n} = 2 * {n}^2")
        n += 1


# return true or false for one odd composite.
def can_be_expressed_as_the_sum_yadda_yadda(oc):
    prime_candidates = []
    for pc in primes():
        if pc >= oc:
            break
        prime_candidates.append(pc)
    # print(f"{oc=} {prime_candidates=}")

    for pc in prime_candidates:
        diff = oc - pc

        if diff % 2 == 1:
            # print(f"{oc - pc=} is odd; continuing")
            continue

        # print(f"{pc=} {oc - pc=}")
        double_square_candidates = []
        for dc in double_squares():
            if dc > diff:
                break
            double_square_candidates.append(dc)
        # print(f"{double_square_candidates=}")

        for index, dsc in enumerate(double_square_candidates):
            if dsc == diff:
                print(f"{oc} = {pc} + 2 × {index + 1}²")
                return True

    return False


if __name__ == "__main__":
    print(list(itertools.islice(odd_composites(), 10)))
    with concurrent.futures.ProcessPoolExecutor() as executor:
        oc = odd_composites()
        found_one = False
        while not found_one:
            futures = []
            while len(futures) < 10:
                futures.append(executor.submit(can_be_expressed_as_the_sum_yadda_yadda, next(oc)))

            for f in concurrent.futures.as_completed(futures):
                if not f.result:
                    found_one = True
                    break
