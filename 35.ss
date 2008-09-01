#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define (all-rotations seq)
  (let ([original-length (length seq)])
    (let loop ([l original-length]
               [seq (apply circular-list seq)]
               [result '()])
      (if (zero? l)
          result
          (loop (sub1 l)
                (cdr seq)
                (cons (take seq original-length) result))))))

(define (all-number-rotations n)
  (map digits->number (all-rotations (digits n))))

(define (circular-prime? n)
  (every prime? (all-number-rotations n)))

(length (filter circular-prime? (build-list 1000000 values)))
