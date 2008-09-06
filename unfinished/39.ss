#lang scheme

(require (lib "26.ss" "srfi")
         (lib "1.ss" "srfi")
         "../coordinates.ss"
         "../divisors.ss"
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

(define (sqr x)
  (* x x))

(define (hash-append table key value)
  ;; I wonder if I should use "lset-adjoin" instead of "cons"
  (hash-set table key (cons value (hash-ref table key '()))))

;; Find Pythagorean triples the dumbest possible way
(for*/fold ([triples-by-perimeter (make-immutable-hash '())])
    ([(a b) (in-coordinates-diagonally 100)]
     ;; come up with some guesses for c

     [c (in-range (add1 (max a b)) (ceiling (* 3/2 (max a b))))])

    (if (equal? (sqr c)
                (+ (sqr a)
                   (sqr b)))
        (hash-append triples-by-perimeter (+ a b c) (list a b c))
        triples-by-perimeter))
