#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require (planet soegaard/math/math)
         (planet schematics/schemeunit:3)
         (planet schematics/schemeunit:3/text-ui))

(define (sum-of-divisors n)
  (apply + (cdr (reverse (divisors n)))))

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

(define (main . args)
  (exit (run-tests hmm-tests 'verbose)))
(provide main)
