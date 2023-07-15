from typing import Any, Callable, Iterable

Neighbors = Iterable[Any]


def breadth_first_search(
    *,
    starting_datum: Any,
    get_neighbors: Callable[[Any], Neighbors],
    stopping_criterion: Callable[[Any], bool],
) -> Iterable[Any]:
    def _bfs(
        *,
        queue: list[Any],
        get_neighbors: Callable[[Any], Neighbors],
        stopping_criterion: Callable[[Any], bool],
    ) -> Iterable[Any]:
        print(f"{queue=}")

        datum = queue.pop(0)

        if stopping_criterion(datum):
            yield datum
            return

        for n in get_neighbors(datum):
            if n not in queue:
                queue.append(n)

        yield from _bfs(
            queue=queue,
            get_neighbors=get_neighbors,
            stopping_criterion=stopping_criterion,
        )

    yield from _bfs(
        queue=[starting_datum],
        get_neighbors=get_neighbors,
        stopping_criterion=stopping_criterion,
    )


def test_it() -> None:
    def get_neighbors(n: Any) -> Neighbors:
        def inc(x: int, delta: int) -> int:
            return min(10, x + delta)

        rv = []
        for offset in ((1, 0), (0, 1), (1, 1)):
            candidate = (inc(n[0], offset[0]), inc(n[1], offset[1]))
            if candidate != n:
                rv.append(candidate)
        # print(f"{n=} neighbors={rv}")
        return rv

    def stopping_criterion(n: Any) -> bool:
        return bool(n == (10, 10))

    assert [(10, 10)] == list(
        breadth_first_search(
            starting_datum=(0, 0),
            get_neighbors=get_neighbors,
            stopping_criterion=stopping_criterion,
        )
    )
