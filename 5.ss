#lang scheme

;; least-common multiple, if I'm not mistaken

(require (planet "math.ss" ("soegaard" "math.plt")))

(define *exponents-by-prime* (make-hash))
(define (hash-maximize! table key value)
  (hash-set! table key
             (max value (hash-ref table key 0))))
(for ([i (in-range 1 21)])
  (map (lambda (pair)
         (match pair
           [(list factor how-many-of-em)
            (hash-maximize! *exponents-by-prime* factor how-many-of-em)]

           [_ 'meh]))

       (factorize i)))

(for/fold ([accum 1])
          ([(factor exponent) (in-hash *exponents-by-prime*)])
  (* accum (expt factor exponent)))


