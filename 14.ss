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
(trace note!)
(define (already-known? starting-number)
  (hash-ref *seq-lengths-by-starting-number* starting-number #f))
(define (seq-length-starting-at n)
  (let loop ((n n)
             (seq '()))
    (printf "n is ~a~%" n)
    (aif it (or (already-known? n)
                (= 1 n))
         (begin
           (for ([elt (in-list seq)]
                 [seq-length (in-naturals 1)])
             (note! elt seq-length))
           (+ (or (already-known? n) 0)
              (length seq)))
         (loop (next n)
               (cons n seq)))))

(seq-length-starting-at 10 )
(seq-length-starting-at 100 )
(seq-length-starting-at 1000)
