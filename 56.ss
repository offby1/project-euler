#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 5863 2008-12-21 17:13:36Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme

(require (planet soegaard/math/math))

(for*/fold ([max 0])
    ([a (in-range 100)]
     [b (in-range 100)])
    (let* ((e (expt a b))
           (sum (apply + (digits e))))
      (if (< max sum)
           sum
           max)))

