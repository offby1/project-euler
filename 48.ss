#lang scheme

(require math/number-theory)

(with-modulus
 (expt 10 10)
 (for/fold ([sum 0])
     ([n (in-range 1 1001)])
   (mod+ sum (modexpt n n))))
