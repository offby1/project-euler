#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (except-in srfi/1 first second))

(define (same-digits? . numbers)
  (define (same-digits-2? n m)
    (equal? (sort (digits n) <)
            (sort (digits m) <)))
  (andmap ((curry same-digits-2?) (car numbers)) (cdr numbers)))

(check-true  (same-digits? 12 21))
(check-false (same-digits? 12 22))
(check-false (same-digits? 10 1))

(define (winner? x)
  (apply
   same-digits?
   (map ((curryr *) x)(build-list 5 (compose add1 add1)))))

(let loop ([candidate 1])
  (if (winner? candidate)
      (map ((curryr *) candidate) (build-list 6 add1))
      (loop (add1 candidate))))
