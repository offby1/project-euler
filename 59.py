import collections
import pprint
import string
import operator
import itertools

with open ('p059_cipher.txt') as inf:
    s = inf.read()
    ciphertext = [int(n) for n in s.split(',')]


def attempt_decryption(key_triplet):
    key_cycle = itertools.cycle([ord(c) for c in key_triplet])

    for key, cipher in zip(key_cycle, ciphertext):
        yield chr(key ^ cipher)


def all_decryptions():
    for triplet in itertools.product(string.ascii_lowercase,
                                     string.ascii_lowercase,
                                     string.ascii_lowercase):
        yield triplet, ''.join(attempt_decryption(triplet))


def count_letters(ostensible_plaintext):
    return sum(1 for c in ostensible_plaintext if c.isalpha())


def ascii_sum(str):
    return sum(ord(c) for c in str)


for index, (triplet, ostensible_plaintext) in enumerate(sorted(all_decryptions(),
                                                               key=lambda p: count_letters(p[1]),
                                                               reverse=True)):
    print('{} ({}): {}'.format(triplet, ascii_sum(ostensible_plaintext), ostensible_plaintext))

    if index > 9:
        break
