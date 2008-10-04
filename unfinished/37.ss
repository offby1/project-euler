#lang scheme

(require srfi/26
         (except-in srfi/1 first second)
         "../coordinates.ss"
         (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         mzlib/trace)

(define (left-truncatable-prime? digits)
  (or (null? digits)
      (and (prime? (digits->number digits))
           (left-truncatable-prime? (cdr digits)))))
(trace left-truncatable-prime?)
(check-true (left-truncatable-prime? '(3 7 9 7)))
