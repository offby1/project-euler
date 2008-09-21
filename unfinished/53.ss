#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi")
         (file "../coordinates.ss"))

(for/fold ([pairs 0])
    ([(n r) (in-coordinates-diagonally 101)])

  (+
   pairs
   (if (< 1000000 (binomial n r)) 1 0)
   ))
