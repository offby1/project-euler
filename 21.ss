#lang scheme

(require "divisors.ss"
         (lib "26.ss" "srfi")
         (planet schematics/schemeunit:3))

;; "cut" is cool.  It's analogous to (but syntactially, slightly
;; clunkier than) the "arc" language's square brackets.  In arc, [ + 3
;; _ ] is syntax that expands to (lambda (_) (+ 3 _)); (cut + 3 <>) is
;; the equivalent.  Afaik, both forms deal only with single-argument
;; functions.

(define (d n)
  (apply + (filter (cut < <> n) (all-divisors-of n))))

(check-equal? (d 220) 284)
(check-equal? (d 284) 220)

(define (is-amicable? i)
  (= i (d (d i))))

(apply
 +
 (for/fold ([amicable-pairs '()])
   ([i (in-range 10000)])
   (let ((sod (d i)))
     (if (and (not (= i sod))
              (= i (d sod)))
         (cons i amicable-pairs)
         amicable-pairs))))
