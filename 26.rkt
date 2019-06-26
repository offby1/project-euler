#!/usr/bin/env racket

#lang racket
(require math/number-theory)

(define (length-of-repeated-fraction denom)
  (if (coprime? 10 denom)
      (unit-group-order 10 denom)
      0))

(for/fold ([winner '(0 . 0)])
    ([candidate (in-range 2 1000)])
    (let ([l (length-of-repeated-fraction candidate)])
      (if (< (cdr winner) l)
          (cons candidate l)
          winner)))
