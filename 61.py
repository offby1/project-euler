import dataclasses
import functools
import itertools


# https://en.wikipedia.org/wiki/Polygonal_number#Formula
def P(s: int):
    def formula(n):
        return ((s - 2) * n * n - (s - 4) * n) // 2

    return formula


@functools.cache
def polygonals_of_size(s: int):
    rv = []
    for n in itertools.count(1):
        p = P(s)(n)
        if p > 9999:
            return rv
        rv.append (p)


@functools.cache
def four_digit_polygonals_of_size(s: int):
    rv = []

    for t in polygonals_of_size(s):
        if len(str(t)) == 4:
            rv.append(t)
        elif len(str(t)) > 4:
            break

    return rv


def overlaps(head: int, tail: int) -> bool:
    assert 1000 <= head <= 9999
    assert 1000 <= tail <= 9999
    if head == tail:
        return False
    last_two_of_head = head % 100
    first_two_of_tail = tail // 100

    return last_two_of_head == first_two_of_tail


@dataclasses.dataclass(frozen=True)
class Solution:
    fdn_by_size: dict[int, int] = dataclasses.field(default_factory=dict)

    def union(self, size: int, fdn: int):
        return Solution(fdn_by_size=dict(self.fdn_by_size | {size: fdn}))


def solutions_from(s: int):
    for candidate in four_digit_polygonals_of_size(s):
        if s == 5:
            yield Solution(fdn_by_size={s: candidate})
        else:
            for sol in solutions_from(s + 1):
                # print(f"{s=} {candidate=} {sol=}", end=" ")
                fdn_from_larger_size = sol.fdn_by_size[s + 1]
                # print(f"{fdn_from_larger_size=}")
                if overlaps(candidate, fdn_from_larger_size):
                    yield sol.union(s, candidate)


def test_formula():
    one_through_five = range(1, 6)

    assert [P(3)(i) for i in one_through_five] == [1, 3, 6, 10, 15]
    assert [P(4)(i) for i in one_through_five] == [1, 4, 9, 16, 25]
    assert [P(5)(i) for i in one_through_five] == [1, 5, 12, 22, 35]


def test_overlaps():
    assert overlaps(1234, 3456)
    assert not overlaps(3456, 1234)
    assert not overlaps(1111, 1111)


if __name__ == "__main__":
    print(list(solutions_from(3)))
    print(four_digit_polygonals_of_size.cache_info())
