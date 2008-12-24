#lang scheme

(hash-count
 (for*/fold ([terms (make-immutable-hash '())])
     ([a (in-range 2 101)]
      [b (in-range 2 101)])
   (hash-set terms (expt a b) #t)))
