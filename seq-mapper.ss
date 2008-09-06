#lang scheme

(require "coordinates.ss")

(define (transformed-sequence orig-sequence value-transformer)
  ???)

(check-equal?
 (for/list ([(i j)  (in-coordinates-diagonally 3)])
   (list i j))
 '((0 0) (1 0) (2 0) (1 1)))

(define offset-point
  (match-lambda
   [(list x y)
    (list (add1 x)
          (add1 y))]))

(check-equal?
 (for/list ([(i j)  (transformed-sequence (in-coordinates-diagonally 3) offset-point)])
   (list i j))
 '((1 1) (2 1) (3 1) (2 2)))
