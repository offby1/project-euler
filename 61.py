import collections
import dataclasses
import functools
import itertools

import networkx as nx


# https://en.wikipedia.org/wiki/Polygonal_number#Formula
def P(s: int):
    def formula(n):
        return ((s - 2) * n * n - (s - 4) * n) // 2

    return formula


@functools.cache
def polygonals_of_size(s: int):
    rv = []
    for n in itertools.count(1):
        p = P(s)(n)
        if p > 9999:
            return rv
        rv.append (p)


@functools.cache
def four_digit_polygonals_of_size(s: int):
    rv = []

    for t in polygonals_of_size(s):
        if len(str(t)) == 4:
            rv.append(t)
        elif len(str(t)) > 4:
            break

    return rv


if __name__ == "__main__":
    fdns_by_size_and_first_two_digits = collections.defaultdict(lambda: collections.defaultdict(list))
    fdns_by_size_and_last_two_digits = collections.defaultdict(lambda: collections.defaultdict(list))
    sizes_by_fdn = collections.defaultdict(set)

    for size in range(3, 9):
        for fdn in four_digit_polygonals_of_size(size):
            sizes_by_fdn[fdn].add(size)
            first, last = divmod(fdn, 100)
            fdns_by_size_and_first_two_digits[size][first].append(fdn)
            fdns_by_size_and_last_two_digits[size][last].append(fdn)

    G = nx.Graph()
    for size, d in fdns_by_size_and_first_two_digits.items():
        for prefix, p_numbers in d.items():
            for p_n in p_numbers:
                for s_n in fdns_by_size_and_last_two_digits[size][prefix]:
                    G.add_edge(s_n, p_n)
    for cycle in nx.simple_cycles(G, length_bound=6):
        if len(cycle) == 6:
            for fdn in cycle:
                s = sizes_by_fdn[fdn]
                descr = f"size {s.pop()}" if len(s) == 1 else f"sizes {', '.join([str(n) for n in s])}"
                print(f"{fdn}: {descr}", end=", ")
            print()
