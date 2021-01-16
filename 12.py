import itertools
import sympy.ntheory            # python3 -m pip install sympy


def nth_triangular_number(n):
    return n * (n + 1) // 2


if __name__ == "__main__":
    for n in itertools.count():
        tn = nth_triangular_number(n)
        if len(list(sympy.ntheory.factor_.divisors(tn))) > 500:
            print(tn)
            break
