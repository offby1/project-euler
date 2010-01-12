#lang scheme

(require srfi/25
         (planet schematics/schemeunit:3))

(define (row n)
  (map (lambda (i)
         (list i (- n i)))
       (build-list (round (/ (add1 n) 2)) values)))

(define (coordinates n)
  (apply append (map row (build-list n values))))

(define (in-array-coordinates array)
  (make-do-sequence
   (lambda ()
     (values (lambda (seq)
               (values (first seq)
                       (second seq)))
             (lambda (seq)
               (match seq
                 [(list x y)
                  (if (< x (sub1 (array-end array 0)))
                      (list (add1 x) y)
                      (list 0 (add1 y)))]))
             '(0 0)
             (lambda (seq)
               (and
                (< (first seq) (array-end array 0))
                (< (second seq) (array-end array 1))))
             (lambda (x y) #t)
             (lambda (t x y) #t)))))

(provide/contract
 [coordinates (-> natural-number/c (listof (list/c number? number?)))]
 [in-array-coordinates (-> array? sequence?)])
