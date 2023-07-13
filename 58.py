import sympy


def numbers_on_the_diagonal():
    x = 1
    yield {"datum": x, "side length": 1}
    increment = 2
    diagonal_primes_found = 0
    while True:
        for _ in range(4):
            x += increment
            if sympy.isprime(x):
                diagonal_primes_found += 1
            side_length = increment + 1
            diagonal_population = side_length * 2 - 1
            yield {
                "x": x,
                "side_length": side_length,
                "diagonal_population": diagonal_population,
                "diagonal_primes_found": diagonal_primes_found,
            }
        increment += 2


if __name__ == "__main__":
    d = numbers_on_the_diagonal()
    while True:
        data = next(d)
        try:
            if data["diagonal_primes_found"] / data["diagonal_population"] < 0.1:
                print(data["side_length"])
                break
        except KeyError:
            pass
