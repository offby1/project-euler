#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6182 2009-11-10 04:59:27Z erich $
exec  mzscheme -l errortrace --require "$0" --main -- ${1+"$@"}
|#

;; http://stackoverflow.com/questions/352203/generating-permutations-lazily

#lang scheme
(require (planet schematics/schemeunit:3)
         (planet schematics/schemeunit:3/text-ui))

(define (next-permutation seq [less? <])
  "dude, maybe you should write some tests")

(define-test-suite next-permutation-tests

  (let ((stuff 'bother))
    (check-false (next-permutation (list)))
    (check-false (next-permutation (list 1)))
    (check-equal? (next-permutation (list 1 2))  (list 2 1))
    (check-equal? (next-permutation (list 2 1))  (list 1 2))

    (check-equal? (next-permutation (list 1 2 3))  (list 1 3 2))
    (check-equal? (next-permutation (list 1 3 2))  (list 2 1 3))
    (check-equal? (next-permutation (list 2 1 3)) (list 2 3 1))
    (check-equal? (next-permutation (list 2 3 1)) (list 3 1 2))
    (check-equal? (next-permutation (list 3 1 2)) (list 3 2 1))
    (check-false  (next-permutation (list 3 2 1)))
    ))

(define (main . args)
  (exit (run-tests next-permutation-tests 'verbose)))

(provide next-permutation main)
