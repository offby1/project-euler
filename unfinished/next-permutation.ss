#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
#$Id: v4-script-template.ss 6182 2009-11-10 04:59:27Z erich $
exec  mzscheme -l errortrace --require "$0" --main -- ${1+"$@"}
|#

;; http://stackoverflow.com/questions/352203/generating-permutations-lazily

#lang scheme
(require (planet schematics/schemeunit:3)
         (planet schematics/schemeunit:3/text-ui))

;; Find the longest tail that is ordered in decreasing order.
(define (longest-decreasing-tail seq [less? <])
  (for/fold ([so-far '()])
      ([item (in-list (reverse seq))])

      (cond
       ((null? so-far)
        (cons item so-far))
       ((less? (car so-far)
               item)
        (cons item so-far))
       (else
        so-far))))

(define-test-suite longest-decreasing-tail-tests
  (check-equal? (longest-decreasing-tail (list)) '())
  (check-equal? (longest-decreasing-tail (list 1)) '(1))
  (check-equal? (longest-decreasing-tail (list 1 2) )'(2))
  (check-equal? (longest-decreasing-tail (list 2 1))  '(2 1))
  (check-equal? (longest-decreasing-tail (list 3 2 1))  '(3 2 1))
  (check-equal? (longest-decreasing-tail (list 2 3 1)) '(3 1))
  )

(define (smallest-larger-than num decreasing-seq [less? <])
  (cond
   ((null? (cdr described))
    (first seq))
   (else
    (car decreasing-seq))))

(define (replace seq old new)
  seq)
(define (next-permutation seq [less? <])
  (cond
   ((or
     (null? seq)
     (null? (cdr seq)))
    #f)
   (else
    (let ([tail (longest-decreasing-tail seq less?)])
      (if (equal? (length tail)
                  (length seq))
          #f
          (let* ([head (take (- (length seq)
                                (length tail))
                             seq)]
                 [number-just-before-the-tail (last head)]
                 [new (smallest-larger-than number-just-before-the-tail tail less?)])
            (append (drop-right head 1)
                    (list new)
                    (replace tail new number-just-before-the-tail))
            )))))
  )

(define-test-suite next-permutation-tests

  (let ((stuff 'bother))
    (check-false (next-permutation (list)))
    (check-false (next-permutation (list 1)))
    (check-equal? (next-permutation (list 1 2))  (list 2 1))
    (check-equal? (next-permutation (list 2 1))  (list 1 2))

    (check-equal? (next-permutation (list 1 2 3))  (list 1 3 2))
    (check-equal? (next-permutation (list 1 3 2))  (list 2 1 3))
    (check-equal? (next-permutation (list 2 1 3)) (list 2 3 1))
    (check-equal? (next-permutation (list 2 3 1)) (list 3 1 2))
    (check-equal? (next-permutation (list 3 1 2)) (list 3 2 1))
    (check-false  (next-permutation (list 3 2 1)))
    ))

(define (main . args)
  (exit (run-tests next-permutation-tests 'verbose)))

(provide next-permutation main)
