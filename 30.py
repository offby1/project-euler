def is_sum_of_fifth_powers_of_digits(n):
    digits = [int(c) for c in str(n)]

    s = sum([pow(d, 5) for d in digits])
    if n == s:
        return s


if __name__ == "__main__":
    answer = 0
    for num in range(1000, 1_000_000):
        if s := is_sum_of_fifth_powers_of_digits(num):
            print(f"Ooh ooh {s}")
            answer += s

    print(f"Final answer for project euler: {answer}")
