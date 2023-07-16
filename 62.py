import collections
import itertools

cubes_by_sorted_digits = collections.defaultdict(set)

for number in itertools.count(1):
    cube = pow(number, 3)
    sorted_digits = ''.join(sorted(str(cube)))
    cubes_by_sorted_digits[sorted_digits].add(cube)

    if len(cubes_by_sorted_digits[sorted_digits]) == 5:
        print(f"{cube}: {cubes_by_sorted_digits[sorted_digits]=}")
        for c in cubes_by_sorted_digits[sorted_digits]:
            print(f"{c} = {int(round(pow(c, 1/3)))}³")
        print("---")
        print(min(cubes_by_sorted_digits[sorted_digits]))
        break
