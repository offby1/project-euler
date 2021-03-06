import heapq
import itertools
import string
import sys

import tqdm                     # pip install tqdm

with open ('p059_cipher.txt') as inf:
    s = inf.read()
    ciphertext = [int(n) for n in s.split(',')]


def attempt_decryption(key_triplet):
    key_cycle = itertools.cycle([ord(c) for c in key_triplet])

    for key, cipher in zip(key_cycle, ciphertext):
        yield chr(key ^ cipher)


def all_decryptions():
    n = len(string.ascii_lowercase)

    print("Computing all decryptions...", file=sys.stderr)
    for triplet in tqdm.tqdm(itertools.product(string.ascii_lowercase,
                                               string.ascii_lowercase,
                                               string.ascii_lowercase),
                             total=(n * n * n)):
        yield triplet, ''.join(attempt_decryption(triplet))


def count_letters(ostensible_plaintext):
    return sum(1 for c in ostensible_plaintext if c.isalpha())


def ascii_sum(str):
    return sum(ord(c) for c in str)


# Assume that the correct decryption is the one with the most letters
# (as opposed to punctuation &c)
for triplet, ostensible_plaintext in heapq.nlargest(10, all_decryptions(), key=lambda p: count_letters(p[1])):
    print(f"{triplet} ({ascii_sum(ostensible_plaintext)}): {ostensible_plaintext}")
