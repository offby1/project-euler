import math

import tqdm


def fiboniccis():
    first = 1
    second = 1
    yield first
    yield second
    while True:
        first, second = second, first + second
        yield second


def is_pandigital(digit_string):
    return "0" not in digit_string and len(set(digit_string)) == 9


def last_nine_digits(number):
    number = number % 1_000_000_000
    return str(number)


def first_nine_digits(number):
    l_ = math.log10(number)

    if l_ < 9:
        return str(number)
    l_ = int(l_) - 8

    number //= pow(10, l_)

    return str(number)


if __name__ == "__main__":
    for index, fib in tqdm.tqdm(enumerate(fiboniccis()), total=329468):
        index += 1

        # for reasons I don't understand, last_nine_digits is super-fast, whereas first_nine_digits is super-slow.  So
        # only do the slow one if the fast one has succeeded.
        if not is_pandigital(last_nine_digits(fib)):
            continue

        if is_pandigital(first_nine_digits(fib)):
            print(f"{index=} {first_nine_digits(fib)}...{last_nine_digits(fib)}")
            break
