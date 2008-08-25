#lang scheme

(define (row n)
  (map (lambda (i)
         (list i (- n i)))
       (build-list (round (/ (add1 n) 2)) values)))

(define (coordinates n)
  (apply append (map row (build-list n values))))

(provide/contract
 [coordinates (-> natural-number/c (listof natural-number/c))])