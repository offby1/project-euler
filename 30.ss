#lang scheme

(require math/number-theory
         "digits.ss"
         (planet schematics/schemeunit:3)
         (except-in srfi/1 first second))

(define (sum-of-nth-powers n k)
  (apply + (map ((curryr expt) n) (digits k))))

(define (all-sums n)
  (let loop ([k 2]
             [magic '()])
    (if (< k 1000000)
        (let ((s (sum-of-nth-powers n k)))
          (loop (add1 k)
                (if (= s k)
                    (cons k magic)
                    magic)))
        (reverse magic))))

(check-equal? (all-sums 4) '(1634 8208 9474))

(apply + (all-sums 5))
