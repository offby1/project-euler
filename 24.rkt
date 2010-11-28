#lang scheme

(require (only-in "next-permutation.rkt" *order* next-permutation))

(parameterize ([*order* <])
  (for/fold ([current-permutation (vector 0 1 2 3 4 5 6 7 8 9)])
      ([counter (in-range 1 1000000)])
      (next-permutation current-permutation)))
