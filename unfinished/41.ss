#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 5863 2008-12-21 17:13:36Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require lazy/force
         "lazy-perms.ss"
         (planet soegaard/math/math))

(provide main)
(define (main . args)
  (let loop ((seq (perms (reverse (build-list 10 values)))))
    (let ((candidate (digits->number (!! (car (! seq))))))
      (if (prime? candidate)
          candidate
          (loop  (cdr (! seq)))))))
