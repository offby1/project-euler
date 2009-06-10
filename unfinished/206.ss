#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 5863 2008-12-21 17:13:36Z erich $
exec  mzscheme --require "$0" --main -- ${1+"$@"}
|#

#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet schematics/schemeunit:3/text-ui))

(define (looks-right d)
  (regexp-match
   #rx"^1.2.3.4.5.6.7.8.9.0$"
   (number->string d)))

(define winner
  (+
   (* (expt 10 00) 0)
   (* (expt 10 18) 1)
   (* (expt 10 16) 2)
   (* (expt 10 14) 3)
   (* (expt 10 12) 4)
   (* (expt 10 10) 5)
   (* (expt 10 08) 6)
   (* (expt 10 06) 7)
   (* (expt 10 04) 8)
   (* (expt 10 02) 9)

   (* (expt 10 01) a)
   (* (expt 10 03) b)
   (* (expt 10 05) c)
   (* (expt 10 07) d)
   (* (expt 10 09) e)
   (* (expt 10 11) f)
   (* (expt 10 13) g)
   (* (expt 10 15) h)
   (* (expt 10 17) i)
   ))


(define smallest 1020304050607080900)
(define largest  1929394959697989990)

(define (isqrt x)
  (inexact->exact (round (sqrt x))))

(for ([i (in-range (isqrt smallest)
                   (isqrt (add1 largest)))])
  (when (looks-right (* i i))
    (printf "W00t: ~a~%" i)))

(define tests
  (test-suite
   "yeah"
   (check-not-false (looks-right 1727374757677787970))
   (check-false     (looks-right 17273747576777879706) "trailing digit")
   (check-false     (looks-right 11727374757677787970) "leading digit")))

(provide main)
(define (main . args)
  (exit (run-tests tests 'verbose)))
