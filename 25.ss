#lang scheme

;; (0 . 1) => (1 . 1)
(define (next-fib state)
  (cons (cdr state)
        (+ (car state)
           (cdr state))))

(define (log10 x)
  (/ (log x)
     (log 10)))

(let loop ([state '(1 . 1)]
           [term-number 2])
  (if (< (log10 (cdr state))
         999)
      (loop
       (next-fib state)
       (add1 term-number))
      term-number))
