#lang scheme

(require math/number-theory
         (planet schematics/schemeunit:3)
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi"))

(define *triple-play* 285)

(define (winner? n)
  (let ((t (triangle-number n)))
    (and (pentagonal-number? t)
         (hexagonal-number?  t))))

(check-true (winner? *triple-play*))

(let loop ([n (add1 *triple-play*)])
  (if (winner? n)
      (triangle-number n)
      (loop (add1 n))))
