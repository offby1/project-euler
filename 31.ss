#lang scheme

(define *denominations* '(1 2 5 10 20 50 100 200))

;; Stolen outta SICP
(define (ways-to-make-change amount denoms)
  (cond
   ((negative? amount)
    0)
   ((zero? amount)
    1)
   ((null? denoms)
    0)
   (else
    (+ (ways-to-make-change (- amount (car denoms)) denoms)
       (ways-to-make-change amount (cdr denoms))))))

(ways-to-make-change 200 *denominations*)
