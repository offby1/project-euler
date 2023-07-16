import itertools

from bfs import Neighbors, NodeType, breadth_first_search


def test_it() -> None:
    MAX_COORD = 2
    DIMENSIONS = 4

    def get_neighbors(n: NodeType) -> Neighbors:
        def inc(x: int, delta: int) -> int:
            return min(MAX_COORD, x + delta)

        for offset in sorted(itertools.product(range(2), repeat=DIMENSIONS), key=sum):
            candidate = list(map(inc, n, [int(i) for i in offset]))
            if candidate != list(n):
                yield candidate

    nodes_visited: list[NodeType] = []

    def stopping_criterion(n: NodeType) -> bool:
        return bool(len(nodes_visited) == pow((MAX_COORD + 1), DIMENSIONS))

    def per_datum_work(datum: NodeType) -> None:
        print(f"{datum=} sum:{sum(datum)}")
        nodes_visited.append(datum)

    list(
        breadth_first_search(
            starting_datum=[0] * DIMENSIONS,
            get_neighbors=get_neighbors,
            per_datum_work=per_datum_work,
            stopping_criterion=stopping_criterion,
        )
    )

    assert len(nodes_visited) == pow((MAX_COORD + 1), DIMENSIONS)
