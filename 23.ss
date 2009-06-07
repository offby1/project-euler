#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6058 2009-05-17 23:00:11Z erich $
exec  mzscheme -l errortrace --require "$0" --main -- ${1+"$@"}
|#

#lang scheme
(require (planet soegaard/math/math)
         schemeunit
         schemeunit/text-ui
         srfi/26)

(define (sum-of-divisors n)
  ;; Soegaard's "divisors" always includes 1..n inclusive, but we
  ;; don't want to include N.
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

(define-test-suite hmm-tests
  (check-equal? 'perfect (classify 28)))

(define (exit-if-non-zero n)
  (when (not (zero? n))
    (exit n)))

(define (main . args)
  (exit-if-non-zero (run-tests hmm-tests 'verbose))

  (let ()
    (define *lotsa-abundant-numbers*
      (time(for/fold ([abs '()])
          ([candidate (in-range 1 (add1
                                   ;; 200
                                   28123
                                   ))])
          (if (equal? 'abundant (classify candidate))
              (cons candidate abs)
              abs))))

    (define *sums-of-two-abundant-numbers*
      (time(for*/fold ([sums (make-immutable-hash '())])
          ([a (in-list *lotsa-abundant-numbers*)]
           [b (in-list (filter [cut <= <> a] *lotsa-abundant-numbers*))])
          (hash-set sums (+ a b) #t))))

    (define *largest-sum*
      (time (* 2
               (for*/fold ([m 0])
                   ([a (in-hash-keys *sums-of-two-abundant-numbers*)])
                   (max a m)))))

    (define *not-sums*
      (time(for/fold ([them '()])
          ([candidate (in-range *largest-sum*)])
          (if (hash-ref *sums-of-two-abundant-numbers* candidate #f)
              them
              (cons candidate them)))))

    (printf "The largest sum of two interesting abundant numbers: ~a~%" *largest-sum*)

    (if (< (length *lotsa-abundant-numbers*) 100)
        (begin
          (printf "The abundant numbers of interest: ~a~%" *lotsa-abundant-numbers*)
          (printf "The list of sums: ~a~%" *sums-of-two-abundant-numbers*)
          (printf "The list of not-sums ~a:~%" *not-sums*))
        (begin
          (printf "There are ~a abundant numbers of interest~%" (length *lotsa-abundant-numbers*))
          (printf "The list of sums has ~a entries~%" (dict-count *sums-of-two-abundant-numbers*))
          (printf "The list of not-sums has ~a entries~%" (length *not-sums*))))
    (printf "And the final answer is: ~a~%" (apply + *not-sums*))
    )
  )
(provide main)
