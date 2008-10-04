#lang scheme

(require srfi/26
         (except-in srfi/1 first second)
         "../coordinates.ss"
         (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         mzlib/trace)

(define (left-truncatable-prime? digits)
  (or (null? digits)
      (and (prime? (digits->number digits))
           (left-truncatable-prime? (cdr digits)))))
;; (trace left-truncatable-prime?)
(check-true (left-truncatable-prime? '(3 7 9 7)))

(define (right-truncatable-prime? digits)
  (or (null? digits)
      (and (prime? (digits->number digits))
           (right-truncatable-prime? (take digits (sub1 (length digits)))))))
;; (trace right-truncatable-prime?)
(check-true (right-truncatable-prime? '(3 7 9 7)))

(let loop ((trials 0)
           (found '()))
  (if (= (length found) 11 )
      found
      (let ((candidate
             (digits
              (nth-prime
               ;; Add 5 to skip over 2, 3, 5, and 7
               (+ 5 trials)))))
        (loop (add1 trials)
              (if (and (left-truncatable-prime?  candidate)

                       (right-truncatable-prime? candidate))
                  (begin
                    (printf "~a!~%" candidate)
                    (cons candidate found))
                  found)))))