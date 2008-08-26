#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(define (sqrt n) (integer-root n 2))

(define n (/ (sub1 (sqrt (add1 (* 8 (factorial 502))))) 2))

(define *solution* (triangle (ceiling n)))

(triangle? *solution*)
