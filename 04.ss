#lang racket

(require (only-in srfi/13 string-reverse))

(define (euler4e)
  (for*/fold ([greatest 0]) ([first (in-range 101 1000)] [second (in-range first 1000)])
             (define prod (* first second))
    (if (palindromic? prod) (max greatest prod) greatest)))

(define (palindromic? n)
  (define s (number->string n))
  (define r (string-reverse s))
  (string=? s r))

(euler4e)
