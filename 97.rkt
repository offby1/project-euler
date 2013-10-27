#lang racket

(require math/number-theory)

(with-modulus
 (expt 10 10)
 (mod+ 1 (mod* 28433 (modexpt 2 7830457))))
