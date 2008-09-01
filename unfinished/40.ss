#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
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

(define x (digit-generator))
(x)
(x)
(x)
(x)

(define (nth-digit n)
  (for/fold ([result 0])
      ([i (in-range n)])
    (x)))
