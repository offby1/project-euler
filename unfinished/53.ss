#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi")
         "coordinates.ss")

(for/fold ([pairs 0])
    ([(n r) (in-coordinates-diagonally 101)])
  ;; in-coordinates-diagonally will never return a pair whose two
  ;; values are equal, but we want to consider those, too.  So we fake
  ;; it: every time it returns a pair where r is 0, we also consider
  ;; the case where r is n.
  (define (one-if-its-big n r)
    (if (< 1000000 (binomial n r)) 1 0))
  (+
   pairs
   (one-if-its-big n r)
   (if (= 1 (- n r))
       (one-if-its-big n n)
       0)))