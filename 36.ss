#lang scheme

(require math/number-theory
         "digits.ss")

(define (binary-digits n)
  ;; rewrite of soegaard'd "digits", but with 2 instead of 10.  He
  ;; really needs to parameterize the base, or allow me to pass it in
  ;; as an argument.
  (define (d x)
    (if (< x 2)
        (list x)
        (cons (remainder x 2)
              (d (quotient x 2)))))
  (unless (integer? n)
    (error 'digits "expected an integer, got: n"))
  (reverse (d (if (negative? n) (- n) n))))

(define (palindrome? seq)
  (equal? seq (reverse seq)))

(define (base-2-palindrome? x)
  (palindrome? (binary-digits x)))

(define (base-10-palindrome? x)
  (palindrome? (digits x)))

(for/fold ([sum 0])
    ([n (in-range 1000000)])
  (if (and (base-2-palindrome? n)
           (base-10-palindrome? n))
      (+ n sum)
      sum))
