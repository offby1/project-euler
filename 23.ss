#lang debug racket

(require math/number-theory
         racket/sequence)

(define (set-sum s)
  (for/sum ([elt s])
    elt))

(define (set-max s)
  (inexact->exact
   (for/fold ([result -inf.0])
       ([elt s])
     (max elt result))))

(define (sum-of-divisors n)
  (- (apply + (divisors n))
     n))

(define (abundant? n)
  (> (sum-of-divisors n) n))

(module+ main
  (define *N* 29000
    ;; 20161
    )

  (define *lotsa-abundant-numbers*
    (sequence-filter abundant? (in-range *N*)))

  (define *sums*
    (for*/set ([a *lotsa-abundant-numbers*]
               [b (sequence-filter (curry > a) *lotsa-abundant-numbers*)])
      (+ a b)))



  (define largest-sum (set-max *sums*))

  (define *not-sums*
    (set-subtract  (apply set (sequence->list largest-sum))
                   *sums*))

  (module+ test
    (require rackunit)
    (define largest-not-sum (set-max *not-sums*))
    (check < largest-not-sum *N*))

  (set-sum *not-sums*)
  )
