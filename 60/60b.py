import itertools

import sympy


def concat(n1, n2):
    return int(str(n1) + str(n2))


def are_groovy_concatenable_prime_pair(p1, p2):
    c1 = concat(p1, p2)
    print(f"Checking {c1=}")
    if not sympy.isprime(c1):
        return False
    c2 = concat(p2, p1)
    print(f"Checking {c2=}")
    if not sympy.isprime(c2):
        return False
    return True


def is_good(list_o_primes):
    for p1, p2 in itertools.combinations(list_o_primes, r=2):
        if not are_groovy_concatenable_prime_pair(p1, p2):
            return False

    return True


def chug(current_five):
    for _ in itertools.count():
        if is_good(current_five):
            print("Woo hoo")
            return (current_five)

        next_prime = sympy.nextprime(current_five[-1])

        for index in range(len(current_five) - 1, -1, -1):
            backup = current_five[index]
            current_five[index] = next_prime
            if str(_).rstrip("0") == "1":
                print(f"{_} {current_five=} {index=}")
            if is_good(current_five):
                print("Woo hoo")
                return current_five
            current_five[index] = backup

        current_five.append(next_prime)
        current_five.pop(0)


if __name__ == "__main__":
    print(chug([sympy.prime(n) for n in range(1, 6)]))
