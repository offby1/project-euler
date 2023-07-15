import itertools


# https://en.wikipedia.org/wiki/Polygonal_number#Formula
def P(s: int):
    def formula(n):
        return ((s - 2) * n * n - (s - 4) * n) // 2

    return formula


def _triangulars():
    for n in itertools.count(1):
        yield P(3)(n)


def four_digit_triangulars():
    for t in _triangulars():
        if len(str(t)) == 4:
            yield t
        elif len(str(t)) > 4:
            return


t = four_digit_triangulars()


def test_formula():
    one_through_five = range(1, 6)

    assert [P(3)(i) for i in one_through_five] == [1, 3, 6, 10, 15]
    assert [P(4)(i) for i in one_through_five] == [1, 4, 9, 16, 25]
    assert [P(5)(i) for i in one_through_five] == [1, 5, 12, 22, 35]
