#lang debug racket

(require math/number-theory
         racket/sequence)

(define (proper-divisors n)
  (set-remove
   (apply set (divisors n))
   n))

(define (sum-of-divisors n)
  (apply + (set->list (proper-divisors n))))

(define (classify n)
  (let ((s (sum-of-divisors n)))
    (cond
     ((< s n)
      'deficient)
     ((= s n)
      'perfect)
     (else
      'abundant))))

(define (abundant? n)
  (eq? 'abundant (classify n)))

(define *N* 29000
            ;; 20161
                 )

(define *lotsa-abundant-numbers*
  (sequence-filter abundant? (in-range *N*)))

(define *sums*
  (for*/set ([a *lotsa-abundant-numbers*]
             [b *lotsa-abundant-numbers*])
    (+ a b)))

(define (set-max s)
  (inexact->exact
   (for/fold ([result -inf.0])
       ([elt s])
     (max elt result))))

(define largest-sum (set-max *sums*))

(define *not-sums*
  (set-subtract  (apply set (sequence->list largest-sum))
                 *sums*))

(module+ test
  (require rackunit)
  (define largest-not-sum (set-max *not-sums*))
  (check < largest-not-sum *N*))

(apply + (set->list *not-sums*))
