;; Translation of "divyekapoor"'s solution, seen at
;; http://projecteuler.net/index.php?section=forum&id=10

#lang scheme

;; #t means "prime".  We assume a number is prime until we've found
;; otherwise.
(let ((sieve (make-vector 2000000 #t)))

  ;; We know these aren't prime, so mark 'em
  (vector-set! sieve 0 #f)
  (vector-set! sieve 1 #f)

  (for ([(is-prime? index) (in-indexed sieve)])
    (when (vector-ref sieve index)

      ;; This number is prime; mark its multiples as composite.
      (for ([victim (in-range (* 2 index) (vector-length sieve) index)])
          (vector-set! sieve victim #f))))

  ;; Now only the primes in the sieve are marked #t; sum 'em up.
  (for/fold ([sum 0])
      ([(is-prime? index) (in-indexed sieve)])
      (+ sum (if is-prime? index 0))))
