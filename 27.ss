#lang scheme
(require math/number-theory)

(define (prime/safe n)
  (and (positive? n)
       (prime? n)))

(define (number-of-consecutive-primes quadratic)
  (let loop ((n 0))
    (if (prime/safe (quadratic n))
        (loop (add1 n))
        n)))

(module+ main

  (define-values (best length)
    (for*/fold ([best-quadratic #f]
                [length 0])
        ([a (in-range -1000 1000)]
         [b (in-range -1000 1000)])

      (define (quadratic n)
        (+ (* n n)
           (* n a)
           b))

      (let ((this-length (number-of-consecutive-primes quadratic)))
        (if (< length this-length)
            (values (list a b) this-length)
            (values best-quadratic length)))))

  (apply * best))
