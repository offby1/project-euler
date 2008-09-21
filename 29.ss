#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi"))

(hash-count
 (for*/fold ([terms (make-immutable-hash '())])
     ([a (in-range 2 101)]
      [b (in-range 2 101)])
   (hash-set terms (expt a b) #t)))
