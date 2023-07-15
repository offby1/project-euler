import itertools


# https://en.wikipedia.org/wiki/Polygonal_number#Formula
def P(s: int):
    def formula(n):
        return ((s - 2) * n * n - (s - 4) * n) // 2

    return formula


def polygonals_of_size(s: int):
    for n in itertools.count(1):
        yield P(s)(n)


def four_digit_polygonals(s: int):
    for t in polygonals_of_size(s):
        if len(str(t)) == 4:
            yield t
        elif len(str(t)) > 4:
            return


def overlaps(head: int, tail: int) -> bool:
    assert 1000 <= head <= 9999
    assert 1000 <= tail <= 9999
    if head == tail:
        return False
    return str(tail).startswith(str(head)[-2])


def solutions_from(s: int):
    for candidate in four_digit_polygonals(s):
        if s == 8:
            yield {candidate}
            return
        assert s < 8, f"wtf {s=}"
        for sol in solutions_from(s + 1):
            for number in sol:
                if overlaps(candidate, number):
                    yield sol.union([candidate])


s = solutions_from(3)


def test_formula():
    one_through_five = range(1, 6)

    assert [P(3)(i) for i in one_through_five] == [1, 3, 6, 10, 15]
    assert [P(4)(i) for i in one_through_five] == [1, 4, 9, 16, 25]
    assert [P(5)(i) for i in one_through_five] == [1, 5, 12, 22, 35]


def test_overlaps():
    assert overlaps(1234, 3456)
    assert not overlaps(3456, 1234)
    assert not overlaps(1111, 1111)
