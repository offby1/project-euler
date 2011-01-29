#lang racket

(define (triples perimeter)
  (for*/fold ([trips '()])
      ([a (in-range (add1 perimeter))]
       [b (in-range a)])
      (let ([c (- perimeter a b)])
        (if (equal? (* c c)
                    (+ (* a a)
                       (* b b)))
            (cons (list a b c) trips)
            trips))))

(for/fold ([winning-perimeter 0]
           [winning-trips '()])
    ([perimeter (in-range 1 1001)])
    (let ([trips (triples perimeter)])
      (if (< (length winning-trips) (length trips))
          (values  perimeter trips)
          (values winning-perimeter winning-trips))))
