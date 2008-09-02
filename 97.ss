#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(with-modulus
 (expt 10 10)
 (+ 1 (* 28433 (expt 2 7830457))))
