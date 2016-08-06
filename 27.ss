#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require math/number-theory)

(provide main)

(define (prime/safe n)
  (and (positive? n)
       (prime? n)))

(define (number-of-consecutive-primes quadratic)
  (let loop ((n 0))
    (if (prime/safe (quadratic n))
        (loop (add1 n))
        n)))

(define (main . args)

  (define-values (best length)
    (for*/fold ([best-quadratic #f]
                [length 0])
        ([a (in-range -1000 1000)]
         [b (in-range -1000 1000)])

      (define (quadratic n)
        (+ (* n n)
           (* n a)
           b))

      (let ((this-length (number-of-consecutive-primes quadratic)))
        (if (< length this-length)
            (values (list a b) this-length)
            (values best-quadratic length)))))

  (apply * best))
