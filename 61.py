def P(i: int):
    inner_factors = [..., ..., ..., 1, 1, 3, 2, 5, 3]
    denominators_ = [..., ..., ..., 2, 1, 2, 1, 2, 1]
    subtrahends__ = [..., ..., ..., -1, 0, 1, 1, 3, 2]

    def formula(n):
        return n * (inner_factors[i] * n - subtrahends__[i]) / denominators_[i]

    return formula


def test_formula():
    one_through_five = range(1, 6)

    assert [P(3)(i) for i in one_through_five] == [1, 3, 6, 10, 15]
    assert [P(4)(i) for i in one_through_five] == [1, 4, 9, 16, 25]
