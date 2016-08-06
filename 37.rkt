#lang racket
(require rackunit
         (only-in math/number-theory prime? next-prime)
         "digits.ss")

(define (sans-first-digit n)
  (digits->number (cdr (digits n))))

(define (sans-last-digit n)
  (digits->number (drop-right (digits n) 1)))

(define (left-truncatable? n)
  (or (zero? n)
      (and (prime? n)
           (left-truncatable? (sans-first-digit n)))))

(define (right-truncatable? n)
  (or (zero? n)
      (and (prime? n)
           (right-truncatable? (sans-last-digit n)))))

(define (truncatable? n)
  (and (left-truncatable? n)
       (right-truncatable? n)))

(define (eligible? n)
  (and (< 7 n)
       (truncatable? n)))

(check-true  (eligible? 3797))
(check-false (eligible? 2))
(check-false (eligible? 3))
(check-false (eligible? 5))
(check-false (eligible? 7))

(let loop ([truncatable-primes '()]
           [length 0]
           [candidate (next-prime 0)])
  (if (< length 11)
      (if (eligible? candidate)
          (loop (cons candidate truncatable-primes)
                (add1 length)
                (next-prime candidate))
          (loop truncatable-primes
                length
                (next-prime candidate)))
      (apply + truncatable-primes)))


