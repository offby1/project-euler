#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define (same-digits? n m)
  (equal? (sort (digits n) <)
          (sort (digits m) <)))

(check-true  (same-digits? 12 21))
(check-false (same-digits? 12 22))
(check-false (same-digits? 10 1))

(define (winner? x)
  (and (same-digits? (* 2 x)
                     (* 3 x))
       (same-digits? (* 3 x)
                     (* 4 x))
       (same-digits? (* 4 x)
                     (* 5 x))
       (same-digits? (* 5 x)
                     (* 6 x))))

(let loop ([candidate 1])
  (if (winner? candidate)
      (map (cut * candidate <>) (build-list 6 add1))
      (loop (add1 candidate))))