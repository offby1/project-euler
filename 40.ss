#lang racket

(require rackunit
         "digits.ss")

(define (digit-generator)
  (let ((the-channel (make-channel)))
    (thread
     (lambda ()
       (let loop ([snork 1])
         (for ([digit (in-list (digits snork))])
           (channel-put the-channel digit))
         (loop (add1 snork)))))
    (lambda ()
      (channel-get the-channel))))

(define (nth-digit n)
  (let ((x! (digit-generator)))
    (for/fold ([result 0])
        ([i (in-range n)])
      (x!))))

(module+ test
  (check-equal? (nth-digit 12) 1))

(module+ main
  (let* ([interesting-indices (set 0  9 99 999 9999 99999 999999)]
         [biggest-index (apply max (set->list interesting-indices))])
    (for/product ([(digit index) (in-indexed (in-producer (digit-generator)))])
      #:break (> index biggest-index)
      (if (set-member? interesting-indices index)
          (begin
            (printf "~a: ~a~%" index digit)
            digit)
          1))))
