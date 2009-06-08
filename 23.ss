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

(define (dict-first d)
  (dict-iterate-next d (dict-iterate-first d)))

(define (max-key dict)
  (for/fold ([m (dict-first dict)])
      ([elt (in-dict-keys dict)])
      (max m elt)))

(define (main . args)
  (exit-if-non-zero (run-tests hmm-tests 'verbose))

  (let ()
    (define *lotsa-abundant-numbers*
      (time(for/fold ([abs '()])
          ([candidate (in-range 1
                                30000   ; just a guess; apparently
                                        ; it's large enough
                                )])
          (if (equal? 'abundant (classify candidate))
              (cons candidate abs)
              abs))))

    (define *not-sums-of-two-abundant-numbers*
      (time
       (let ([zeroes
              (for*/fold ([not-sums (make-immutable-hash '())])
                  ([a (in-list *lotsa-abundant-numbers*)]
                   [b (in-list (filter [cut <= <> a] *lotsa-abundant-numbers*))])
                  (hash-set not-sums (+ a b) 0))])
         (for/fold ([final zeroes])
             ([candidate (in-range (add1 (max-key zeroes)))])
             (if (hash-has-key? final candidate)
                 (hash-remove final candidate)
                 (hash-set final candidate 1))
             ))))

    (if (< (hash-count *not-sums-of-two-abundant-numbers*) 100)
        (begin
          (printf "The abundant numbers of interest: ~a~%" *lotsa-abundant-numbers*)
          (printf
           "The set of not-sums: ~a~%"
           (for/fold ([filtered '()])
               (((k v)
                 (in-hash *not-sums-of-two-abundant-numbers*)))
               (if (zero? v)
                   filtered
                   (cons k filtered )))))
        (begin
          (printf "There are ~a abundant numbers of interest~%" (length *lotsa-abundant-numbers*))
          (printf "The set of not-sums has ~a entries~%" (hash-count *not-sums-of-two-abundant-numbers*))))
    (printf
     "And the final answer is: ~a~%"
     (for/fold ([sum 0])
         ([candidate (in-range (add1 28123))])
         (+ sum (* candidate (hash-ref *not-sums-of-two-abundant-numbers* candidate 0)))))))

(provide main)
