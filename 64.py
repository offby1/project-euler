import tqdm

from sympy.ntheory.continued_fraction import continued_fraction_periodic

found = 0

for N in tqdm.tqdm(range(1, 10_001)):
    cf = continued_fraction_periodic(p=0, q=1, d=N)
    if len(cf) < 2:
        continue                # "continue", get it?
    period = cf[1]
    if len(period) % 2 == 1:
        found += 1

print(found)
