#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi"))

(define expand-factors
  (match-lambda [(list base exp)  (expt base exp)]))

(printf "Cycle length:\tnumbers < 1000~%")
(let loop ([power-of-ten 1]
           [factors-seen '()])
  (when (< power-of-ten 200)
    (let* ((nines (sub1 (expt 10 power-of-ten)))
           (factors (factorize nines)))
      (let ((numbers
             (filter
              (cut < <> 1000)
              (map expand-factors (lset-difference equal? factors factors-seen)))))
        (printf "~a:\t\t" power-of-ten)
        (if (not (null? numbers))
            (printf "~a~%" numbers)
            (printf "~%")))
      (loop (add1 power-of-ten)
            (apply lset-adjoin equal? factors-seen factors)))))