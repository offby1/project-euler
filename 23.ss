#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme -l errortrace --require "$0"  -- ${1+"$@"}
|#

#lang scheme
(require (planet soegaard/math/math)
         (prefix-in set: (planet soegaard/galore:4:1/set))
         schemeunit
         schemeunit/text-ui
         srfi/26)

(define (sum-of-divisors n)
  ;; Soegaard's "divisors" always includes 1..n inclusive, but we
  ;; don't want to include N.
  (- (apply + (divisors n)) n))

(define (classify n)
  (let ((s (sum-of-divisors n)))
    (cond
     ((< s n)
      'deficient)
     ((= s n)
      'perfect)
     (else
      'abundant))))

;; Everything below this point was more or less directly stolen from
;; "Hooked"'s Python solution of 28 Mar 2007 07:53 am as found on
;; http://projecteuler.net/index.php?section=forum&id=23&page=2

(define *N* 20161)

(define *lotsa-abundant-numbers*
  (time
   (reverse
    (for/fold ([abs '()])
        ([candidate (in-range 1
                              *N*       ; just a guess; apparently
                                        ; it's large enough
                              )])
        (if (equal? 'abundant (classify candidate))
            (cons candidate abs)
            abs)))))

(printf "I found ~a abundant numbers less than ~a~%"
        (length *lotsa-abundant-numbers*)
        *N*)
(printf "~a ... ~a~%"
        (take *lotsa-abundant-numbers* 3)
        (take-right *lotsa-abundant-numbers* 3))

(define *possible* (make-hash))

(time
 (for ([a (in-list *lotsa-abundant-numbers*)])
   (let/ec break
     (for ([b (in-list *lotsa-abundant-numbers*)])
       (if (< (+ a b) *N*)
           (hash-set! *possible* (+ a b) #t)
           (break))))))

(printf
 "And the final answer is: ~a~%"
 (for/fold ([sum 0])
     ([p (in-range *N*)])
     (if (hash-ref *possible* p #f)
         sum
         (+ sum p))))
