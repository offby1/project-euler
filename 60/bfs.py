from typing import Any, Callable, Iterable

NodeType = Any
Neighbors = Iterable[NodeType]


def breadth_first_search(
    *,
    starting_datum: NodeType,
    get_neighbors: Callable[[NodeType], Neighbors],
    per_datum_work: Callable[[NodeType], None],
    stopping_criterion: Callable[[NodeType], bool],
) -> Iterable[NodeType]:
    def _bfs(
        *,
        queue: list[NodeType],
    ) -> Iterable[NodeType]:
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
    )
