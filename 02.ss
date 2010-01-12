#lang scheme

(define (in-fibs-not-exceeding *max*)
  (make-do-sequence
   (lambda ()
     (values second
             (lambda (current)
               (list (second current)
                     (apply + current)))
             '(0 1)
             (lambda (current)
               (< (second current) *max*))
             (lambda (v) #t)
             (lambda (t v) #t)))))

(for/fold ([sum 0])
    ((f (in-fibs-not-exceeding 4000000)))
  (+ sum
     (if (even? f)
         f
         0)))
