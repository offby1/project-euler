#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi"))

(define (repeating-fraction-length n)
  (when (null? (delete 5 (delete 2  (map first (factorize n)))))
    (error 'repeating-fraction-length "1/~a isn't a repeating fraction!" n))
  (let loop ([nines 9]
             [length 1])
    (if (zero? (remainder nines n))
        length
        (loop (+ 9 (* 10 nines))
              (add1 length)))))
