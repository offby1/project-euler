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


def four_digits_starting_with(s: int, first_two_digits: int):
    assert 10 <= first_two_digits <= 99
    yielded = 0
    for candidate in four_digit_polygonals(s):
        if str(candidate).startswith(str(first_two_digits)):
            yield candidate
            yielded += 1
        else:
            if yielded:
                return  # save time by not trying the bigger candidates


t = four_digits_starting_with(3, 11)


def test_formula():
    one_through_five = range(1, 6)

    assert [P(3)(i) for i in one_through_five] == [1, 3, 6, 10, 15]
    assert [P(4)(i) for i in one_through_five] == [1, 4, 9, 16, 25]
    assert [P(5)(i) for i in one_through_five] == [1, 5, 12, 22, 35]
