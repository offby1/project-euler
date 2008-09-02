#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define *triple-play* 40755)

(define (winner? n)
  (and (triangle?   n)
       (pentagonal? n)
       (hexagonal?  n)))

(check-true (winner? *triple-play*))

(let loop ([n (add1 *triple-play*)])
  (if (winner? n)
      n
      (loop (add1 n))))
