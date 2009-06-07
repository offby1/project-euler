#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme

(require (planet soegaard/math/math))

(provide main)
(define (main . args)
  (for*/fold ([pairs 0])
      ([n (in-range 1 101)]
       [r (in-range (add1 n))])

      (+
       pairs
       (if (< 1000000 (binomial n r)) 1 0)
       )))
