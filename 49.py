import sympy


def has_the_problem_49_property(n):
    the_numbers = list(range(n, n + (3330 * 3), 3330))

    for candidate in the_numbers:
        if not sympy.isprime(candidate):
            return False

    sets_of_digits = [set(str(n)) for n in the_numbers]
    if all(s == sets_of_digits[0] for s in sets_of_digits):
        print(the_numbers)
        return True

    return False


for candidate in range(1000, 10_000):
    if has_the_problem_49_property(candidate):
        print(candidate)

        if candidate != 1487:
            break
