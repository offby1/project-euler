#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define (sum-of-fifth-powers n)
  (apply + (map (cut expt <> 5) (digits n))))

(let loop ([n 0])
  (when (< n 10000000)
   (let ((s (sum-of-fifth-powers n)))
     (when (= n s)
       (printf "~a => ~a~%" n s)))
   (loop (add1 n))))
