#lang debug racket

(require math/number-theory
         racket/sequence
         rackunit)

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

(define (turn-the-crank *N*)

  (define *lotsa-abundant-numbers*
    (sequence-filter abundant? (in-range *N*)))

  ;; (printf "The abundants: ~a~%" (sequence->list *lotsa-abundant-numbers*))

  (define *sums*
    (for*/set ([a *lotsa-abundant-numbers*]
               [b (sequence-filter (curry >= a) *lotsa-abundant-numbers*)])
      (+ a b)))

  ;; (printf "Sums of two abundants: ~a~%" (sort (set->list *sums*) <))

  (define largest-sum (set-max *sums*))

  (define *all-them-integers* (apply set (sequence->list (add1 largest-sum))))
  ;; (displayln (sort (set->list *all-them-integers*) <))

  (define *not-sums*
    (set-subtract *all-them-integers* *sums*))

  (printf "N is ~a; ~a abundant numbers less than that; ~a sums of pairs of such; ~a not-sums.~%"
          *N*
          (sequence-length *lotsa-abundant-numbers*)
          (set-count *sums*)
          (set-count *not-sums*))
  )

(module+ main
  (let loop ([*N* 20])
    (when (< *N*   28123)
      (turn-the-crank *N*)
      (loop (inexact->exact (round (* *N* 2.15)))))
    )

  )
