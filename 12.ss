#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (except-in (lib "1.ss" "srfi") first second)
         (planet schematics/schemeunit:3))

(define all-exponents
  (match-lambda
   [(list prime exponent)
    (map (lambda (e)
           (expt prime e))
         (build-list (add1 exponent) values))]))
(check-equal? (all-exponents '(3 4)) '(1 3 9 27 81))

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
(check-equal? (multiply '(foo bar) '(baz ugh) '(splode))
              '((foo baz splode) (foo ugh splode) (bar baz splode) (bar ugh splode)))

(define (all-divisors-of n)
  (delete-duplicates
   (sort
    (map (lambda (nums)
           (apply * nums)) (apply multiply (map all-exponents (factorize n))))
    <)))
(check-equal? (all-divisors-of 10) '(1 2 5 10))

(define (count-divisors n)
  (length (all-divisors-of n)))

(define (number-of-divisors-of-triangular-number n)
  (count-divisors (triangle n)))

(let loop ((n 1))
  (if (< 500 (number-of-divisors-of-triangular-number n))
      (triangle n)
      (loop (add1 n))))
