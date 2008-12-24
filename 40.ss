#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi")
         mzlib/trace)

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
(check-equal? (nth-digit 12) 1)

(apply * (map nth-digit '(1  10  100  1000  10000  100000  1000000)))
