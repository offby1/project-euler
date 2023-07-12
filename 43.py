import functools
import itertools
import operator
from typing import Iterator, cast

import more_itertools
import tabulate
import tqdm

TEN_FACTORIAL = functools.reduce(operator.__mul__, range(1, 11))
SMALL_PRIMES = [2, 3, 5, 7, 11, 13, 17]

Explanation = list[str]


def all_pandigits() -> Iterator[int]:
    for p in tqdm.tqdm(
        itertools.permutations("0123456789"),
        total=TEN_FACTORIAL,
    ):
        yield int("".join(p))


def has_the_property(n: int) -> Explanation | None:
    zero_padded_string = str(n).zfill(10)
    triples = cast(Iterator[str], more_itertools.windowed(zero_padded_string, n=3))
    next(triples)  # we don't care about the triple d1d2d3
    description = []
    for t, p in zip(triples, SMALL_PRIMES):
        three_digit_number = int("".join(t))
        if three_digit_number % p != 0:
            return None
        description.append(
            f"{three_digit_number} divmod {p} => {divmod(three_digit_number, p)}"
        )
    return description


def all_pandigits_with_the_property() -> Iterator[tuple[int, Explanation]]:
    for pd in all_pandigits():
        if hooray := has_the_property(pd):
            yield pd, hooray


def test_all_pandigits() -> None:
    assert 4567890123 in all_pandigits()
    assert 6789012354 in all_pandigits()


def test_has_the_property() -> None:
    assert has_the_property(1406357289)
    assert not has_the_property(1406357298)


if __name__ == "__main__":
    table = list(all_pandigits_with_the_property())

    stringified_table = []
    for n, explanations in table:
        stringified_table.append([str(n)] + explanations)

    headers = ["N", *[str(p) for p in SMALL_PRIMES]]

    print(tabulate.tabulate(stringified_table, headers=headers))
    print()
    print(sum(thing[0] for thing in table))
