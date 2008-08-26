#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(define (sqrt n) (integer-root n 2))

(define *guesses*
  (map (lambda (num-factors)
         (triangle (ceiling
             (/ (sub1 (sqrt (add1 (* 8 (factorial num-factors))))) 2))))
       (list 499 500 501)))

