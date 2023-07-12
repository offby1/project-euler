from typing import Iterator


def concatenated_product(number: int, each_of: list[int]) -> int:
    products = []
    for i in each_of:
        products.append(number * i)

    return int(''.join([str(p) for p in products]))


def test_192():
    assert concatenated_product(192, [1, 2, 3]) == 192384576


def test_9():
    assert concatenated_product(9, [1, 2, 3, 4, 5]) == 918273645


def is_nine_digit_pandigital(n: int) -> bool:
    digits_seen = set()
    for d in str(n):
        if d in digits_seen:
            return False
        if d == "0":
            return False
        digits_seen.add(d)
    return len(digits_seen) == 9


def the_problem(n: int) -> Iterator[int]:
    candidate_integer = 1
    biggest_concatenated_product = 0
    while True:
        cp = concatenated_product(candidate_integer, range(1, n + 1))
        if len(str(cp)) > 9:
            return

        if not is_nine_digit_pandigital(cp):
            pass
        elif cp <= biggest_concatenated_product:
            pass
        else:
            biggest_concatenated_product = cp
            yield cp

        candidate_integer += 1


if __name__ == "__main__":
    solutions = set()
    for n in range(2, 1000):
        try:
            solutions.add(max(the_problem(n)))
        except ValueError:
            pass

    print(max(solutions))
