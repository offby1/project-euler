#lang scheme
(require (only-in (planet soegaard/math/math) factorize)
         (only-in srfi/1 delete-duplicates)
         rackunit)

;; Much faster replacement for soegaard's "positive-divisors"
;; function.  No idea where I got the algorithm, or how it works, or
;; anything.

(define (all-exponents prime exponent)
  (map (curry expt prime)
       (build-list (add1 exponent) values)))

(check-equal? (all-exponents 3 4) '(1 3 9 27 81))

(define (multiply . lists)
  (define (foobar lst lsts)
    (if (null? lsts)
        (map list lst)
      (apply append (map (lambda (elt)
                           (map (curry cons elt) lsts))
                         lst))))

  (if (null? lists)
      '()
    (foobar (car lists) (apply multiply (cdr lists)))))
(check-equal? (multiply '(foo bar) '(baz ugh) '(splode))
              '((foo baz splode) (foo ugh splode) (bar baz splode) (bar ugh splode)))

(define (all-divisors-of n)
  (delete-duplicates
   (sort
    (map (curry apply *) (apply multiply (map (curry apply all-exponents) (factorize n))))
    <)))
(check-equal? (all-divisors-of 10) '(1 2 5 10))

(define (all-divisors-smaller-than n)
  (drop-right (all-divisors-of n) 1))
(check-equal? (all-divisors-smaller-than 10) '(1 2 5))

(provide/contract
 [all-divisors-of           (-> natural-number/c (listof natural-number/c))]
 [all-divisors-smaller-than (-> natural-number/c (listof natural-number/c))])
