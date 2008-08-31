#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(with-modulus
 (expt 10 10)
 (for/fold ([sum 0])
     ([n (in-range 1 1001)])
   (+ sum (^ n n))))
