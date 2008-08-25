#lang scheme

(require "coordinates.ss")

(define (in-coordinates-diagonally *max*)
  (make-do-sequence
   (lambda ()
     (values values
             (lambda (current)
               (cond
                ((< 1 (- (first current) (second current)))
                 (list (sub1 (first current))
                       (add1 (second current))))
                ((= 1 (- (first current) (second current)))
                 (list (add1 (+ (first current) (second current)))
                       0))
                (else
                 (list (add1 (* 2 (first current)))
                       0)))
               )
             '(0 0)
             (lambda (current)
               (< (first current) *max*))
             (lambda (v) #t)
             (lambda (t v) #t)))))

(for/list ([f (in-coordinates-diagonally 10)])
  f)
