#lang scheme
(require math/number-theory
         srfi/26)

(define (sum-of-divisors n)
  ;; "divisors" always includes 1..n inclusive, but we don't want to
  ;; include N.
  (- (apply + (divisors n)) n))

(define (classify n)
  (let ((s (sum-of-divisors n)))
    (cond
     ((< s n)
      'deficient)
     ((= s n)
      'perfect)
     (else
      'abundant))))

;; Everything below this point was more or less directly stolen from
;; "Hooked"'s Python solution of 28 Mar 2007 07:53 am as found on
;; http://projecteuler.net/index.php?section=forum&id=23&page=2

(define *N* 20161)

(define *lotsa-abundant-numbers*
  (time
   (for/fold ([abs '()])
       ([candidate (in-range 1
                             *N*        ; just a guess; apparently
                                        ; it's large enough
                             )])
       (if (equal? 'abundant (classify candidate))
           (cons candidate abs)
           abs))))

(printf "I found ~a abundant numbers less than ~a~%"
        (length *lotsa-abundant-numbers*)
        *N*)
(printf "~a ... ~a~%"
        (take *lotsa-abundant-numbers* 3)
        (take-right *lotsa-abundant-numbers* 3))

(define *not-sums* (make-hash))

(time
 (for* ([a (in-list *lotsa-abundant-numbers*)]
        [b (in-list *lotsa-abundant-numbers*)])
   (when (< (+ a b) *N*)
     (hash-set! *not-sums* (+ a b) #t))))

(define *correct* 4159710)
(define *computed*
  (time
   (for/fold ([sum (/ (* (sub1 *N*) *N*) 2)])
       ([p (in-hash-keys *not-sums*)])
       (- sum p))))

(printf "And the final answer is: ~a~%" *computed*)
(when (equal? *computed* *correct*)
  (printf "Oh goody.~%")
  (exit 0))

(printf "Oh crap.~%")
(exit 1)
