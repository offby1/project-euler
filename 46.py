# stolen from https://www.ivl-projecteuler.com/overview-of-problems/5-difficulty/problem-46
import sympy


def goldbachs(number):
    for x in range(1, number):
        square = x * x

        if sympy.isprime(number - 2 * square):
            return True

        if square > number:
            break

    return False


def compute():
    candidate = 9
    while True:
        if not sympy.isprime(candidate) and not goldbachs(candidate):
            return candidate
        candidate += 2


if __name__ == "__main__":
    print(compute())
