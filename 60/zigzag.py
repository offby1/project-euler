import dataclasses


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
