#lang scheme

;; least-common multiple, if I'm not mistaken

(for/fold ([accum 1])
          ([i (in-range 1 21)])
  (/ (* accum i) (gcd accum i)))
