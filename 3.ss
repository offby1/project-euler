#lang scheme

;; Stolen from the prose at
;; http://blog.functionalfun.net/2008/03/project-euler-problem-3.html

(define (first-number-which-divides n)
  (let loop ([candidate 2])
    (if (zero? (remainder n candidate))
        candidate
        (loop (add1 candidate)))))

(define (reduce-by n p)
  (let loop ([n n])
    (let-values (((q r) (quotient/remainder n p)))
      (if (zero? r)
          (loop q)
          n))))

(define (largest-prime-factor n)
  (let ([p (first-number-which-divides n)])
    (if p
        (let ((reduced (reduce-by n p)))
          (if (= 1 reduced)
              p
              (largest-prime-factor reduced)))
        n)))
