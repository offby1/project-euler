#lang scheme

(require  (planet soegaard/math/math)
          (only-in srfi/1 circular-list every))

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

(define (all-number-rotations n)
  (map digits->number (all-rotations (digits n))))

(define (circular-prime? n)
  (every prime? (all-number-rotations n)))

(let ([result (filter circular-prime? (build-list 1000000 values))])
  (printf "~a circular primes: ~a~%" (length result) result))
