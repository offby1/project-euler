def reverse_(n):
    return int(''.join(reversed(str(n))))


def all_odd_digits(n):
    odds = {'1', '3', '5', '7', '9'}
    return all(d in odds for d in str(n))


def reversable(n):
    return ((n % 10 > 0)
            and
            all_odd_digits(n + reverse_(n)))


def reversibles_less_than(max):
    for n in range(1, max):
        if reversable(n):
            yield (n)

for index, r in enumerate(reversibles_less_than(1000)):
    print('{}: {} + {} => {}'.format(index + 1,
                                     r,
                                     reverse_(r),
                                     r + reverse_(r)))


#print(count_reversables())
