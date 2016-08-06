#lang racket

(require (only-in "next-permutation.rkt" *order* all-permutations)
         math/number-theory
         "digits.ss")

;; Start computing all permutations of the nine non-zero digits.
(define *the-channel* (make-channel))

;; I originally tried 1 through 9 and 1 through 8; those failed to
;; return anything.  Thank God I was able to avoid checking numbers
;; that contained zeroes; that'd have taken me all century.
(parameterize ([*order* >])
  (all-permutations (vector 1 2 3 4 5 6 7) *the-channel*))

(let loop ()
  (let ([perm (channel-get *the-channel*)])
    (if (not perm)
        "Oops."
        (let ([candidate (digits->number (vector->list perm))])
          (cond
           ((prime? candidate)
            candidate)
           (else
            (loop)))))))
