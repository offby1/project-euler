#lang scheme

(require (planet "memoize.ss" ("dherman" "memoize.plt" )))

(define (row n)
  (map (lambda (i)
         (list i (- n i)))
       (build-list (round (/ (add1 n) 2)) values)))

(define (coordinates n)
  (apply append (map row (build-list n values))))

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
