#lang scheme

(require "coordinates.ss")

(define (in-coordinates-diagonally *max*)
  (make-do-sequence
   (lambda ()
     (values (lambda (seq)
               (values (first seq)
                       (second seq)))
             (lambda (seq)
               (match seq
                 [(list x y)
                  (cond
                   ((< 1 (- x y))
                    (list (sub1 x)
                          (add1 y)))
                   ((= 1 (- x y))
                    (list (add1 (+ x y))
                          0))
                   (else
                    (list (add1 (* 2 x))
                          0)))])
               )
             '(0 0)
             (lambda (seq)
               (< (first seq) *max*))
             (lambda (x y) #t)
             (lambda (t x y) #t)))))

(for/list ([(x y) (in-coordinates-diagonally 10)])
  (cons x y))
