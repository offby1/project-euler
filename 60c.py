import more_itertools
import sympy


def prime_stream():
    p = 1
    while True:
        p = sympy.nextprime(p)
        yield p


def five_parallel_streams_no_dups():
    streams = [more_itertools.peekable(prime_stream()) for _ in range(5)]

    while True:
        # Advance streams as needed to ensure they're all different.
        while True:
            head_values = set()
            advance_me = None
            for index, s in enumerate(streams):
                if s.peek() in head_values and advance_me is None:
                    advance_me = s
                    print(f"Gonna advance {index=} {s}")

                head_values.add(s.peek())

            if advance_me is None:
                break

            next(advance_me)

        yield [s.peek() for s in streams]
        # Advance once stream -- not sure which is best -- to make progress
        next(streams[-1])

fp = five_parallel_streams_no_dups()
