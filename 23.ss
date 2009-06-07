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

(define-test-suite hmm-tests
  (check-equal? 'perfect (classify 28)))

(define (exit-if-non-zero n)
  (when (not (zero? n))
    (exit n)))

(define (main . args)
  (exit-if-non-zero (run-tests hmm-tests 'verbose))

  (let ()
    (define *lotsa-abundant-numbers*
      (for/fold ([abs '()])
          ([candidate (in-range (add1 28123))])
          (if (equal? 'abundant (classify candidate))
              (cons candidate abs)
              abs)))

    (define *sums-of-two-abundant-numbers*
      (remove-duplicates
       (sort
        (for*/fold ([sums '()])
            ([a (in-list *lotsa-abundant-numbers*)]
             [b (in-list (filter [cut <= <> a] *lotsa-abundant-numbers*))])
            (cons (+ a b) sums))
        <)))

    (define *not-sums*
      (for/fold ([them '()])
          ([candidate (in-range (last *sums-of-two-abundant-numbers*))])
          (if (member candidate *sums-of-two-abundant-numbers*)
              them
              (cons candidate them))))

    (printf "There are ~a abundant numbers of interest~%" (length *lotsa-abundant-numbers*))
    (printf "That list of sums is ~a long~%" (length *sums-of-two-abundant-numbers*))
    (printf "That list of not-sums is ~a long~%" (length *not-sums*))
    (printf "And the final answer is: ~a~%" (apply + *not-sums*))
    )
  )
(provide main)
