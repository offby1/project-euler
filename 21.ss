#lang scheme

(require "divisors.ss"
         (planet schematics/schemeunit:3))

(define (d n)
  (apply + (filter ((curryr <) n) (all-divisors-of n))))

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
