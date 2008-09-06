#lang scheme

(require (lib "26.ss" "srfi")
         (lib "1.ss" "srfi")
         "../coordinates.ss"
         "../divisors.ss"
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

;; Find Pythagorean triples the dumbest possible way
(for* ([(a b) (in-coordinates-diagonally 20)]
       ;; come up with some guesses for c

       [c (in-range (add1 (max a b)) (ceiling (* 3/2 (max a b))))])

  (printf "A is ~a; B is ~a; C is ~a~%" a b c))