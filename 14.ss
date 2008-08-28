#lang scheme

(define (next n)
  (if (even? n)
      (/ n 2)
      (add1 (* 3 n))))

(define (seq-starting-at n)
  (let loop ((current  n)
             (seq '()))
    (if (= current 1)
        (reverse seq)
        (loop (next current)
              (cons current seq)))))
