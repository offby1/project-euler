#lang racket

(provide digits)
(define (digits n)
  (let loop  ([n n]
              [digits '()])
    (if (zero? n)
        (reverse digits)
        (let-values (([q r] (quotient/remainder n 10)))
          (loop q (cons r digits))))))

(provide digits->number)
(define (digits->number digits)
  (for/fold ([sum 0])
      ([d digits])
      (+ d (* 10 sum))))
