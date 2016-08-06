#lang scheme

(require math/number-theory)

(for*/fold ([pairs 0])
    ([n (in-range 1 101)]
     [r (in-range (add1 n))])

  (+
   pairs
   (if (< 1000000 (binomial n r)) 1 0)
   ))
