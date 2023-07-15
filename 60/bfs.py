from typing import Any, Callable, Iterable

from sympy.combinatorics import GrayCode

Neighbors = Iterable[Any]


def breadth_first_search(
    *,
    starting_datum: Any,
    get_neighbors: Callable[[Any], Neighbors],
    per_datum_work: Callable[[Any], None],
    stopping_criterion: Callable[[Any], bool],
) -> Iterable[Any]:
    def _bfs(
        *,
        queue: list[Any],
        get_neighbors: Callable[[Any], Neighbors],
        per_datum_work: Callable[[Any], None],
        stopping_criterion: Callable[[Any], bool],
    ) -> Iterable[Any]:
        while True:
            if len(queue) == 0:
                break

            datum = queue.pop(0)

            per_datum_work(datum)

            if stopping_criterion(datum):
                yield datum
                break

            for n in get_neighbors(datum):
                if n not in queue:
                    queue.append(n)

    yield from _bfs(
        queue=[starting_datum],
        get_neighbors=get_neighbors,
        per_datum_work=per_datum_work,
        stopping_criterion=stopping_criterion,
    )


def test_it() -> None:
    MAX_COORD = 2
    DIMENSIONS = 3

    def get_neighbors(n: Any) -> Neighbors:
        def inc(x: int, delta: int) -> int:
            return min(MAX_COORD, x + delta)

        rv = []
        gc = GrayCode(DIMENSIONS)

        for offset in gc.generate_gray():
            candidate = list(map(inc, n, [int(i) for i in offset]))
            if candidate != list(n):
                rv.append(candidate)
        # print(f"{n=} neighbors={rv}")
        return rv

    nodes_visited = []

    def stopping_criterion(n: Any) -> bool:
        return len(nodes_visited) == pow((MAX_COORD + 1), DIMENSIONS)

    def per_datum_work(datum: Any) -> None:
        print(f"{datum=} sum:{sum(datum)}")
        nodes_visited.append(datum)

    list(breadth_first_search(
        starting_datum=[0] * DIMENSIONS,
        get_neighbors=get_neighbors,
        per_datum_work=per_datum_work,
        stopping_criterion=stopping_criterion,
    ))

    assert len(nodes_visited) == pow((MAX_COORD + 1), DIMENSIONS)
