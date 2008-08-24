#lang scheme

(require mzlib/trace)

;; These are in descending order, even though it's hard to tell just
;; by looking :)
(define *known-primes* (list 2))

(define (next-prime-internal!)
  (let next-candidate ((candidate (add1 (first *known-primes*))))
    (define is-prime?
      (let loop ((smaller-primes *known-primes*))
        (cond
         ((null? smaller-primes)
          #t)
         ((zero? (remainder candidate (first smaller-primes)))
          #f)
         (else
          (loop (rest smaller-primes))))))
    (if is-prime? (set! *known-primes* (cons candidate *known-primes*))
        (next-candidate (add1 candidate)))))

(define (next-prime-after! p)
  (if (< p (first *known-primes*))
      (first *known-primes*)
      (begin
        (next-prime-internal!)
        (next-prime-after! p))))
(trace next-prime-after!)

(define (prime-factors num)
  (let loop ([num num]
             [factors '()]
             [largest-untested-prime 2])
    (if (= 1 num)
        factors
        (let-values (((q r) (quotient/remainder num largest-untested-prime)))
          (if (zero? r)
              (loop q (cons largest-untested-prime factors) largest-untested-prime)
              (loop num factors (next-prime-after! largest-untested-prime)))))))

(for ((n (in-list '(11 10))))
  (printf "Factors of ~a: ~a~%" n (prime-factors n)))
