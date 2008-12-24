;; Translation of "divyekapoor"'s solution, seen at
;; http://projecteuler.net/index.php?section=forum&id=10

#lang scheme

;; #t means "prime".  We assume a number is prime until we've found
;; otherwise.
(let ((sieve (make-vector 2000000 #t)))

  ;; We know these aren't prime, so mark 'em
  (vector-set! sieve 0 #f)
  (vector-set! sieve 1 #f)

  (let check-starting-at ((checked 2))
    (when (< checked (vector-length sieve))
      (when (vector-ref sieve checked)

        ;; This number is prime; mark its multiples as composite.
        (let mark-composite ((victim (* 2 checked)))
          (when (< victim (vector-length sieve))
            (vector-set! sieve victim #f)
            (mark-composite (+ victim checked)))))

      (check-starting-at (add1 checked))))

  ;; Now the only the primes in the sieve are marked #t; sum 'em up.
  (for/fold ([sum 0])
      ([(is-prime? index) (in-indexed sieve)])
      (+ sum (if is-prime? index 0))))
