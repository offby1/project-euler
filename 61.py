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
def four_digit_polygonals(s: int):
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
    last_two_of_head = str(head)[-2:]
    first_two_of_tail = str(tail)[0:2]
    return last_two_of_head == first_two_of_tail


@dataclasses.dataclass(frozen=True)
class Solution:
    sizes_and_fdns: list[tuple[int, int]]

    # def __post_init__(self):
    #     assert [3 <= size <= 8 for size, _ in self.sizes_and_fdns]
    #     assert [1000 <= fdn <= 9999 for _, fdn in self.sizes_and_fdns]

    #     self.sanity_check()

    def union(self, size: int, fdn: int):
        assert 1000 <= fdn <= 9999
        assert [size > s for s, _ in self.sizes_and_fdns]

        return Solution(sizes_and_fdns=self.sizes_and_fdns + [(size, fdn)])

    def sanity_check(self):
        for size, fdn in self.sizes_and_fdns:
            assert fdn in polygonals_of_size(size)
            print(f"{self} is legit")


def solutions_from(s: int):
    for candidate in four_digit_polygonals(s):
        # print(f"{'*' * s}: {candidate=}")
        if s == 8:
            yield Solution(sizes_and_fdns=[(s, candidate)])
            return
        assert s < 8, f"wtf {s=}"
        for sol in solutions_from(s + 1):
            for _, fdn in sol.sizes_and_fdns:
                if overlaps(candidate, fdn):
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
