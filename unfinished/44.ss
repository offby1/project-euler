#lang scheme

(require (planet "memoize.ss" ("dherman" "memoize.plt" ))
         "coordinates.ss")

(define (pentagonal n)
  (* n (/ (sub1 (* 3 n)) 2)))

(define (is-pentagonal? x)
  (let ((glurph (sqrt (add1 (* 24 x)))))
    (and (integer? glurph)
         (integer? (/ (add1 glurph) 6)))))

(define (happy-pair? a b)
  (and (is-pentagonal? a)
       (is-pentagonal? b)
       (is-pentagonal? (+ a b))
       (let ((diff (abs (- a b))))
         (and (is-pentagonal? diff)
              diff))))

;; Apparently this uses up all available RAM
(sort
 (for/fold ([accum '()])
     ([(x y) (in-coordinates-diagonally 10000)])
     (let ((happiness (happy-pair? x y)))
       (if happiness
           (cons
            (list (list x y) happiness)
            accum)
           accum)))
 <
 #:key last)
