#lang racket
(require (only-in (planet soegaard/math/math) coprime? order))

(define (length-of-repeated-fraction denom)
  (if (coprime? 10 denom)
      (order 10 denom)
      0))

(for/fold ([winner '(0 . 0)])
    ([candidate (in-range 2 1000)])
    (let ([l (length-of-repeated-fraction candidate)])
      (if (< (cdr winner) l)
          (cons candidate l)
          winner)))
