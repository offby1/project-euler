import collections
import functools
import itertools
from typing import Callable

import networkx as nx  # type: ignore


# https://en.wikipedia.org/wiki/Polygonal_number#Formula
def P(s: int) -> Callable[[int], int]:
    def formula(n: int) -> int:
        return ((s - 2) * n * n - (s - 4) * n) // 2

    return formula


@functools.cache
def polygonals_of_size(s: int) -> list[int]:
    rv: list[int] = []
    for n in itertools.count(1):
        p = P(s)(n)
        if p > 9999:
            break
        elif 1_000 <= p:
            rv.append(p)

    return rv


@functools.cache
def four_digit_polygonals_of_size(s: int) -> list[int]:
    rv = []

    for t in polygonals_of_size(s):
        if t > 9999:
            break
        rv.append(t)

    return rv


if __name__ == "__main__":
    fdns_by_size_and_first_two_digits = collections.defaultdict(  # type: ignore
        lambda: collections.defaultdict(list)
    )
    fdns_by_size_and_last__two_digits = collections.defaultdict(  # type: ignore
        lambda: collections.defaultdict(list)
    )
    sizes_by_fdn = collections.defaultdict(set)

    for p_size in range(3, 9):
        for fdn in four_digit_polygonals_of_size(p_size):
            sizes_by_fdn[fdn].add(p_size)
            first, last_ = divmod(fdn, 100)
            fdns_by_size_and_first_two_digits[p_size][first].append(fdn)
            fdns_by_size_and_last__two_digits[p_size][last_].append(fdn)

    G = nx.DiGraph()
    for p_size, p_d in fdns_by_size_and_first_two_digits.items():
        for prefix, p_numbers in p_d.items():
            for p_n in p_numbers:
                for s_size, d_d in fdns_by_size_and_last__two_digits.items():
                    for s_n in d_d[prefix]:
                        G.add_edge(s_n, p_n)

    for cycle in nx.simple_cycles(G, length_bound=6):
        if len(cycle) == 6:
            sizes_in_cycle = set()
            for n in cycle:
                sizes_in_cycle.add(frozenset(sizes_by_fdn[n]))

            if len(sizes_in_cycle) == 6:
                print(sum(cycle))
                break

    # 8256: {3}, 5625: {4}, 2512: {7}, 1281: {8}, 8128: {3, 6}, 2882: {5},
