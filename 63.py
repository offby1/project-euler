import itertools

num_solutions = 0

for exponent in itertools.count(1):
    try:
        for base in range(1, 10): # 10^n is always longer than n digits
            number = pow(base, exponent)
            size = len(str(number))
            if size == exponent:
                print(f"{base}^{exponent} = {number} (size {size})")
                num_solutions += 1
    except ValueError:
        print(num_solutions)
        break
