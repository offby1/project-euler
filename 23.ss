#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require (planet soegaard/math/math)
         schemeunit
         schemeunit/text-ui
         srfi/26)

(define (sum-of-divisors n)
  ;; Soegaard's "divisors" always includes 1..n inclusive, but we
  ;; don't want to include N.
  (- (apply + (divisors n)) n))

(define (classify n)
  (let ((s (sum-of-divisors n)))
    (cond
     ((< s n)
      'deficient)
     ((= s n)
      'perfect)
     (else
      'abundant))))

(define *lotsa-abundant-numbers*
  (for/fold ([abs '()])
      ([candidate (in-range (add1 28123))])
      (if (equal? 'abundant (classify candidate))
          (cons candidate abs)
          abs)))

(define *sums-of-two-abundant-numbers*
  (for*/fold ([sums '()])
      ([a (in-list *lotsa-abundant-numbers*)]
       [b (in-list (filter [cut <= <> a] *lotsa-abundant-numbers*))])
      (cons (+ a b) sums)))

(define-test-suite hmm-tests

  (check-equal? 'perfect (classify 28)))

(define (main . args)
  (printf "There are ~a abundant numbers of interest~%" (length *lotsa-abundant-numbers*))
  (printf "That list of sums is ~a long~%" (length *sums-of-two-abundant-numbers*))
  (exit (run-tests hmm-tests 'verbose)))
(provide main)
