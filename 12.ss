#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(define (sqrt n) (integer-root n 2))

(define (un-triangle x)
  (/ (sub1 (sqrt (add1 (* 8 x)))) 2))

(define *guesses*
  (map (lambda (num-factors)
         (triangle (ceiling
             (un-triangle (factorial num-factors)))))
       (list 499 500 501)))

