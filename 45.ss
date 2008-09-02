#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define *triple-play* 285)

(define (winner? n)
  (let ((t (triangle n)))
    (and (pentagonal? t)
         (hexagonal?  t))))

(check-true (winner? *triple-play*))

(let loop ([n (add1 *triple-play*)])
  (if (winner? n)
      (triangle n)
      (loop (add1 n))))
