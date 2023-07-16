import collections
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
        elif 1_000 <= p:
            rv.append (p)


@functools.cache
def four_digit_polygonals_of_size(s: int):
    rv = []

    for t in polygonals_of_size(s):
        if t > 9999:
            break
        rv.append(t)

    return rv


if __name__ == "__main__":
    fdns_by_size_and_first_two_digits = collections.defaultdict(lambda: collections.defaultdict(list))
    fdns_by_size_and_last__two_digits = collections.defaultdict(lambda: collections.defaultdict(list))
    sizes_by_fdn = collections.defaultdict(set)

    for p_size in range(3, 9):
        for fdn in four_digit_polygonals_of_size(p_size):
            sizes_by_fdn[fdn].add(p_size)
            first, last_ = divmod(fdn, 100)
            fdns_by_size_and_first_two_digits[p_size][first].append(fdn)
            fdns_by_size_and_last__two_digits[p_size][last_].append(fdn)

    # print(f"{len(sizes_by_fdn)=}")
    # import pprint
    # pprint.pprint(dict(fdns_by_size_and_first_two_digits))
    # print(f"{fdns_by_size_and_last__two_digits=}")

    G = nx.DiGraph()
    for p_size, p_d in fdns_by_size_and_first_two_digits.items():
        for prefix, p_numbers in p_d.items():
            for p_n in p_numbers:
                for s_size, d_d in fdns_by_size_and_last__two_digits.items():
                    for s_n in d_d[prefix]:
                        print(f"{p_size=}: Adding edge from {s_n} to {p_n}")
                        G.add_edge(s_n, p_n)
    print(G)
    for cycle in nx.simple_cycles(G, length_bound=6):
        if len(cycle) == 6:
            sizes_in_cycle = set()
            for n in cycle:
                sizes_in_cycle.update(sizes_by_fdn[n])

            if sizes_in_cycle == {3, 4, 5, 6, 7, 8}:
                for fdn in cycle:
                    print(f"{fdn:04}: {sizes_by_fdn[fdn]}", end=", ")
                print()

    # This is the right answer:
    # 8256: {3}, 5625: {4}, 2512: {7}, 1281: {8}, 8128: {3, 6}, 2882: {5},
    # TODO -- figure out how to identify it from amongst all the other six-cycles
