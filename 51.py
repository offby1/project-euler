from typing import Any, Iterable, Iterator

import more_itertools
import sympy


def replacement_indices(number: int) -> Iterator[Any]:
    yield from more_itertools.powerset(range(len(str(number))))


def all_nine_or_ten_replacements(number: int, target_indices: Iterable[int]) -> Iterable[int]:
    rv = []

    exploded = list(str(number))
    for digit in range(10):
        c = exploded.copy()
        for i in target_indices:
            c[i] = str(digit)
        if c[0] != "0":
            rv.append(int("".join(c)))

    return rv


def test_replacement() -> None:
    p = 56003
    indices = (2, 3)
    candidates = list(all_nine_or_ten_replacements(p, indices))
    assert len(candidates) == 10
    primes = set(n for n in candidates if sympy.isprime(n))  # type: ignore
    assert primes == {56003, 56113, 56333, 56443, 56663, 56773, 56993}


if __name__ == "__main__":
    p = 2
    found_one = False
    while not found_one:
        for indices in replacement_indices(p):
            candidates = all_nine_or_ten_replacements(p, indices)
            primes_only = [n for n in candidates if sympy.isprime(n)]  # type: ignore

            if len(primes_only) == 8 and p in primes_only:
                print(f"{p=}: {primes_only}")
                found_one = True
                break

        p = sympy.nextprime(p)  # type: ignore
