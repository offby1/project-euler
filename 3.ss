#lang scheme

(require mzlib/trace
         (lib "1.ss" "srfi"))

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
    (if is-prime?
        (set! *known-primes* (cons candidate *known-primes*))
        (next-candidate (add1 candidate)))))

(define (next-prime-after! p)
  (or (find (lambda (known) (< p known))
            (reverse *known-primes*))
      (begin
        (next-prime-internal!)
        (next-prime-after! p))))

(define (largest-prime-factor-of num)
  (let loop ([num num]
             [prime (last *known-primes*)]
             [largest-prime-factor 1])
    (if (= 1 num)
        (max num largest-prime-factor)
        (let-values (((q r) (quotient/remainder num prime)))
          (if (zero? r)
              (loop q
                    prime
                    prime)
              (loop
               num
               (next-prime-after! prime)
               largest-prime-factor))))))
