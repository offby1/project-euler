#lang scheme

(require (lib "25.ss" "srfi"))

(define (row n)
  (map (lambda (i)
         (list i (- n i)))
       (build-list (round (/ (add1 n) 2)) values)))

(define (coordinates n)
  (apply append (map row (build-list n values))))

;; Returns every pair of integers less than *max*, smallest first.
;; Won't return, e.g., both (1 2) and (2 1); instead only returns one
;; of those two pairs (not sure which).
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
 [in-coordinates-diagonally (-> natural-number/c sequence?)]
 [in-array-coordinates (-> array? sequence?)])
