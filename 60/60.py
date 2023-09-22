import dataclasses
import itertools

import more_itertools
import networkx as nx
import sympy
import tqdm

from zigzag import zigzag_coordinates


def prime_stream():
    p = 1
    while True:
        p = sympy.nextprime(p)
        yield p


@dataclasses.dataclass(frozen=True)
class PrimePair:
    small: int
    large: int

    def __init__(self, a, b):
        assert a != b
        small, large = sorted([a, b])
        object.__setattr__(self, "small", small)
        object.__setattr__(self, "large", large)


def prime_pairs_zigzag():
    columns = more_itertools.seekable(prime_stream())
    rows = more_itertools.seekable(prime_stream())

    for c in zigzag_coordinates():
        if c.col < c.row:
            columns.seek(c.col)
            rows.seek(c.row)
            yield (PrimePair(next(columns), next(rows)))


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


def groovy_concatenable_prime_pairs():
    for pp in prime_pairs_zigzag():
        if are_groovy_concatenable_prime_pair(pp.small, pp.large):
            yield pp


if __name__ == "__main__":
    prime_pair_graph = nx.Graph()
    for pp in tqdm.tqdm(
        itertools.islice(groovy_concatenable_prime_pairs(), 100_000), total=100_000
    ):
        prime_pair_graph.add_edge(pp.small, pp.large)

    print(prime_pair_graph)
    five_cliques = [
        clique for clique in nx.find_cliques(prime_pair_graph) if len(clique) >= 5
    ]
    clique = min(five_cliques, key=sum)
    print(f"solution: {sum(clique)} ({clique=})")
