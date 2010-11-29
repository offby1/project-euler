#lang racket

(require  (planet soegaard/math/math)
          (only-in srfi/1 circular-list every)
          rackunit)

(define (all-rotations seq)
  (let ([circ  (apply circular-list seq)]
        [len (length seq)])
    (for/list ([l (in-range len)])
      (take (list-tail circ l) len))))

(check-equal?
 (apply set (all-rotations (list 'a 'b 'c 'd)))
 (set '(d a b c) '(c d a b) '(b c d a) '(a b c d)))

(define (all-number-rotations n)
  (map digits->number (all-rotations (digits n))))

(define (circular-prime? n)
  (every prime? (all-number-rotations n)))

(let ([result (filter circular-prime? (build-list 1000000 values))])
  (printf "~a circular primes: ~a~%" (length result) result))
