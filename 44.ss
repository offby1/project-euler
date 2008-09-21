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
(when #f
  (sort
   (foldl (lambda (elt accum)
            (let ((happiness (apply happy-pair? elt)))
            (if happiness
                (cons `(,(map (lambda (n)
                                `(n ,n pent(n) ,(pentagonal n)))  elt) diff ,happiness) accum)
                accum)))
          '()
          (coordinates 10000))
   <
   #:key last))
