#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet schematics/schemeunit/text-ui)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in srfi/1 first second)
         (lib "26.ss" "srfi"))

(define (repeating-fraction-length n)
  (when (null? (delete 5 (delete 2  (map first (factorize n)))))
    (error 'repeating-fraction-length "1/~a isn't a repeating fraction!" n))
  (let loop ([nines 9]
             [length 1])
    (if (zero? (remainder nines n))
        length
        (loop (+ 9 (* 10 nines))
              (add1 length)))))

;; http://www.mathpath.org/Algor/algor.long.div.htm
(define/contract (long-division num denom)
  (natural-number/c natural-number/c . -> . rational?)
  (let loop ([num-digits (digits num)]
             [quotient-digits '()])
    (cond
     ((null? num-digits)
      (digits->number (reverse quotient)))
     (else
      (let loop ([num-digits num-digits]
                 [intermediate-divisor 0]))))
    ))

(define-test-suite long-division-tests

  (check-equal? (long-division 3 4) 3/2))

(run-tests long-division-tests 'verbose)
