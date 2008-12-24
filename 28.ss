#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi"))

;; n is the length of the diagonal, from the center 1 to the corner,
;; counting both of those.  So for the spiral from 1 through nine, n
;; is 2.
(define (sum-of-four-corners n)
  (if (= 1 n)
      1
      (let* ((length (sub1 (* 2 n)))
             (ur (expt length 2)))
        (- (* 4 ur)
           (* 6 (sub1 length))))))

(define (diagonal-sum side-length)
  (for/fold ([sum 0])
      ([i (in-range 1 (add1 (/ (add1 side-length) 2)))])
    (+ sum (sum-of-four-corners i))))

(check-equal? (diagonal-sum 5) 101)
(diagonal-sum 1001)
