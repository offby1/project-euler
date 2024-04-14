import more_itertools

products = set()

digits = "123456789"

for p in more_itertools.distinct_permutations(digits):
    for n in range(1, len(digits) - 1):
        for left, middle, right in more_itertools.windowed_complete(p, n):
            if not left:
                continue
            if not right:
                continue

            left = int("".join(left))
            middle = int("".join(middle))
            right = int("".join(right))

            # print(f"{left} * {middle} == {right} ??")
            if left * middle == right:
                print(f"{left} * {middle} == {right}")
                products.add(right)
print(sum(products))
