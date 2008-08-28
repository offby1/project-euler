#lang scheme

(require (planet "aif.ss" ("schematics" "macro.plt"))
         mzlib/trace)

(define (next n)
  (if (even? n)
      (/ n 2)
      (add1 (* 3 n))))

(define (seq-starting-at n)
  (let loop ((n n)
             (seq '()))
    (if (= 1 n)
        (reverse (cons n seq))
        (loop (next n)
              (cons n seq)))))

(let-values (((winning-index its-seq-length)
              (for/fold ([winning-index 0]
                         [its-seq-length 0])
                  ([n (in-range 1 1000000)])
                (let ((seq-length (length (seq-starting-at n))))
                  (if (< its-seq-length seq-length)
                      (values n seq-length)
                      (values winning-index its-seq-length))))
              ))
  (printf "~a generates a sequence of length ~a~%"
          winning-index
          its-seq-length))
