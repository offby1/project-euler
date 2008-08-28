#lang scheme

(require (planet "aif.ss" ("schematics" "macro.plt"))
         mzlib/trace)

(define (next n)
  (if (even? n)
      (/ n 2)
      (add1 (* 3 n))))

(define *seq-lengths-by-starting-number* (make-hash))
(define (note! starting-number length)
  (hash-set! *seq-lengths-by-starting-number* starting-number length))
(define (already-known? starting-number)
  (hash-ref *seq-lengths-by-starting-number* starting-number #f))
(define (seq-length-starting-at n)
  (let loop ((n n)
             (seq '()))
    (aif it (already-known? n)
         (begin
           (for ([elt (in-list seq)]
                 [seq-length (in-naturals (add1 it))])
             (note! elt seq-length))
           it)
         (if (= 1 n)
             (begin
               (note! n 0)
               0)
             (loop (next n)
                   (cons n seq))))))
