#lang scheme

;; given, say, (11 7 5 3 2), return (13 11 7 5 3 2)
(define (next-prime so-far)
  (let next-candidate ((candidate (add1 (first so-far))))
    (define is-prime?
      (let loop ((so-far so-far))
        (cond
         ((null? so-far)
          #t)
         ((zero? (remainder candidate (first so-far)))
          #f)
         (else
          (loop (rest so-far))))))
    (if is-prime? (cons candidate so-far)
        (next-candidate (add1 candidate)))))

(define (in-primes-not-exceeding *max*)
  (make-do-sequence
   (lambda ()
     (values first
             next-prime
             '(2)
             (lambda (current)
               (< (first current) *max*))
             (lambda (v) #t)
             (lambda (t v) #t)))))

(define (primes< n)
  (for/list ((p (in-primes-not-exceeding n)))
    p))

(define (prime-factors num)
  (for/fold ([num num]
             [factors '()])
      ((p (in-primes-not-exceeding num)))
    (let-values (((q r) (quotient/remainder num p)))
      (if (zero? r)
          (values q (cons p factors))
          (values num factors)))))

