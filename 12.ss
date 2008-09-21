#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (except-in srfi/1 first second)
         (planet schematics/schemeunit:3)
         "divisors.ss")

(define (count-divisors n)
  (length (all-divisors-of n)))

(define (number-of-divisors-of-triangular-number n)
  (count-divisors (triangle n)))

(let loop ((n 1))
  (if (< 500 (number-of-divisors-of-triangular-number n))
      (triangle n)
      (loop (add1 n))))
