#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(with-modulus
 (expt 10 10)
 (for/fold ([sum 0])
     ([n (in-range 1 1001)])
   (+ sum (^ n n))))
