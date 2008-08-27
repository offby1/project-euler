#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (except-in (lib "1.ss" "srfi") first second))

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

(define (all-divisors-of n)
  (delete-duplicates
   (sort
    (map (lambda (nums)
           (apply * nums)) (apply multiply (map all-exponents (factorize n))))
    <)))

(define (count-divisors n)
  (length (all-divisors-of n)))

(define (number-of-divisors-of-triangular-number n)
  (count-divisors (triangle n)))

(let loop ((n 1))
  (if (< 500 (number-of-divisors-of-triangular-number n))
      (triangle n)
      (loop (add1 n))))
