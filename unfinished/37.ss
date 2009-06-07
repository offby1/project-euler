#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require schemeunit
         schemeunit/text-ui
         (planet soegaard/math/math))

(define log10
  (let ((log-of-10 (log 10)))
    (lambda (x)
      (/ (log x) log-of-10))))

(define (num-digits n)
  (inexact->exact (floor (add1 (log10 n)))))

(define (sans-first-digit n)
  (remainder n (expt 10 (sub1 (num-digits n)))))

(define (sans-last-digit n)
  (quotient n 10))

(define (left-truncatable? n)
  (or (zero? n)
      (and (prime? n)
           (left-truncatable? (sans-first-digit n)))))

(define (right-truncatable? n)
  (or (zero? n)
      (and (prime? n)
           (right-truncatable? (sans-last-digit n)))))

(define (truncatable? n)
  (and (left-truncatable? n)
       (right-truncatable? n)))

(define (eligible? n)
  (and (< 7 n)
       (truncatable? n)))

(define-test-suite hmm-tests

  (check-true  (eligible? 3797))
  (check-false (eligible? 2))
  (check-false (eligible? 3))
  (check-false (eligible? 5))
  (check-false (eligible? 7)))

(run-tests hmm-tests 'verbose)

(define (main . args)
  (let loop ([truncatable-primes '()]
             [length 0]
             [candidate (next-prime 0)])
    (if (< length 11)
        (if (eligible? candidate)
            (loop (cons candidate truncatable-primes)
                  (add1 length)
                  (next-prime candidate))
            (loop truncatable-primes
                  length
                  (next-prime candidate)))
        (apply + truncatable-primes))))

(provide main)
