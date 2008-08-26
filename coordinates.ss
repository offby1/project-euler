#lang scheme

(define (row n)
  (map (lambda (i)
         (list i (- n i)))
       (build-list (round (/ (add1 n) 2)) values)))

(define (coordinates n)
  (apply append (map row (build-list n values))))

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
                          0)))]))
             '(0 0)
             (lambda (seq)
               (< (first seq) *max*))
             (lambda (x y) #t)
             (lambda (t x y) #t)))))

(provide/contract
 [coordinates (-> natural-number/c (listof (list/c number? number?)))]
 [in-coordinates-diagonally (-> natural-number/c sequence?)])
