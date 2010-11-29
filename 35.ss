#lang racket

(require  (planet soegaard/math/math)
          (only-in srfi/1 circular-list every)
          rackunit)

(define (all-rotations seq)
  (let ([original-length (length seq)])
    (let loop ([l original-length]
               [seq (apply circular-list seq)]
               [result '()])
      (if (zero? l)
          result
          (loop (sub1 l)
                (cdr seq)
                (cons (take seq original-length) result))))))

(check-equal?
 (set (all-rotations (list 'a 'b 'c 'd)))
 (set '((d a b c) (c d a b) (b c d a) (a b c d))))

(define (all-number-rotations n)
  (map digits->number (all-rotations (digits n))))

(define (circular-prime? n)
  (every prime? (all-number-rotations n)))

(when #f
  (let ([result (filter circular-prime? (build-list 1000000 values))])
    (printf "~a circular primes: ~a~%" (length result) result)))
