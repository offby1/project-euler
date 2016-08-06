#lang racket

(provide digits)
(define (digits n)
  (let loop  ([n n]
              [digits '()])
    (if (zero? n)
        digits
        (let-values (([q r] (quotient/remainder n 10)))
          (loop q (cons r digits))))))

(module+ test
  (require rackunit)
  (check-equal? (digits 123) (list 1 2 3)))

(provide digits->number)
(define (digits->number digits)
  (for/fold ([sum 0])
      ([d digits])
      (+ d (* 10 sum))))
