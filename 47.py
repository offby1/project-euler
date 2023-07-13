def smaller_factors_of(n):
    candidate = 2

    while True:
        if candidate * candidate > n:
            return

        if n % candidate == 0:
            yield candidate

        candidate += 1


def prime_generator():
    candidate = 2

    while True:
        if next(smaller_factors_of(candidate), None) is None:
            yield candidate

        if candidate == 2:
            candidate += 1
        else:
            candidate += 2


def prime_factors_of(n):
    if n < 2:
        return

    for candidate in prime_generator():
        q, r = divmod(n, candidate)

        if r == 0:
            # Candidate is a prime factor of n.
            yield candidate

            # Call ourselves recursively on n / candidate, to get those factors too.
            yield from prime_factors_of(q)
            return

        if candidate * candidate > n:
            break

    # We found no candidates (or else we'd have returned, above).
    # So n is prime.
    yield n
    return


for i in range(1_000_000):
    f_i = set(prime_factors_of(i))
    if len(f_i) < 4:
        continue

    f_ii = set(prime_factors_of(i + 1))
    if len(f_ii) < 4:
        continue

    f_iii = set(prime_factors_of(i + 2))
    if len(f_iii) < 4:
        continue

    f_iiii = set(prime_factors_of(i + 3))
    if len(f_iiii) < 4:
        continue

    print(f"{i + 0=} {f_i=}")
    print(f"{i + 1=} {f_ii=}")
    print(f"{i + 2=} {f_iii=}")
    print(f"{i + 3=} {f_iiii=}")

    break
