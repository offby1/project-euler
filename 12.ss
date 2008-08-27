#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
          (lib "1.ss" "srfi"))

(define (sqrt n) (integer-root n 2))

(define (un-triangle x)
  (/ (sub1 (sqrt (add1 (* 8 x)))) 2))

(define *guesses*
  (map (lambda (num-factors)
         (triangle (ceiling
             (un-triangle (factorial num-factors)))))
       (list 499 500 501)))

(define all-exponents
  (match-lambda
   [(list prime exponent)
    (map (lambda (e)
           (expt prime e))
         (build-list (add1 exponent) values))]))

(define (multiply . lists)
  (define (foobar lst lsts)
    (if (null? lsts)
        (map list lst)
      (apply append (map (lambda (elt)
                           (map (lambda (x) (cons elt x)) lsts))
                         lst))))

  (if (null? lists)
      '()
    (foobar (car lists) (apply multiply (cdr lists)))))

(define (all-factors-of n)
  (delete-duplicates
   (sort
    (map (lambda (nums)
           (apply * nums)) (apply multiply (map all-exponents (factorize n))))
    <)))

(define (smallest-number-with-this-many-factors nf)
  (let loop ([candidate 1])
    (let ((num-factors (length (all-factors-of candidate))))
      (if (<= nf num-factors)
          candidate
          (loop (add1 candidate))))))

;; Just plug 501 into the above and wait!!
