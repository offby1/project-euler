import dataclasses
import itertools

import more_itertools
import sympy


def concat(n1, n2):
    return int(str(n1) + str(n2))


def are_groovy_concatenable_prime_pair(p1, p2):
    c1 = concat(p1, p2)
    if not sympy.isprime(c1):
        return False
    c2 = concat(p2, p1)
    if not sympy.isprime(c2):
        return False
    return True


def the_big_test(list_o_primes):
    for p1, p2 in itertools.combinations(list_o_primes, r=2):
        if not are_groovy_concatenable_prime_pair(p1, p2):
            return False

    return True


def primes():
    p = 1
    while True:
        p = sympy.nextprime(p)
        yield p


@dataclasses.dataclass
class Point:
    col: int
    row: int


def zigzag_coordinates():
    current = Point(
        col=0, row=0
    )  # Rightwards increasing column; downwards increasing row
    yield current

    horiz_increment = 1

    def vert_increment():
        return horiz_increment * -1

    just_turned_around = False

    while True:
        # print(f"{current=} {horiz_increment=} {vert_increment=}")

        if current.col == 0 and not just_turned_around:
            horiz_increment = 1

            current.row += 1
            just_turned_around = True
        elif current.row == 0 and not just_turned_around:
            horiz_increment = -1

            current.col += 1
            just_turned_around = True
        else:
            current.col += horiz_increment
            current.row += vert_increment()
            just_turned_around = False

        yield current


z = zigzag_coordinates()


def prime_pairs_zigzag():
    columns = more_itertools.seekable(primes())
    rows = more_itertools.seekable(primes())
    coordinates = zigzag_coordinates()
    for c in coordinates:
        columns.seek(c.col)
        rows.seek(c.row)
        yield (next(columns), next(rows))


def groovy_concatenable_prime_pairs():
    for p1, p2 in prime_pairs_zigzag():
        if p1 <= p2 and are_groovy_concatenable_prime_pair(p1, p2):
            yield frozenset([p1, p2])

solution = set()
for pp1 in groovy_concatenable_prime_pairs():
    solution.update(pp1)

    for pp2 in groovy_concatenable_prime_pairs():
        potential_recruit = pp2 - solution
        if len(potential_recruit) == 1:
            potential_recruit = next(iter(potential_recruit))
            if the_big_test(solution.union([potential_recruit])):
                solution.add(potential_recruit)
                print(f"{solution=}")
                if len(solution) == 5:
                    print("woohoo")
                    print(solution)
                    raise Exception("Outta here")
                solution.remove(potential_recruit)


def test_the_big_test():
    assert the_big_test([3, 7, 109, 673]) is True
