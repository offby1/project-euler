#lang racket

(require (except-in srfi/1 first second)
         "digits.ss")

(define (all-equal? . things)
  (let loop ([things things])
    (cond
     ((null? things)
      #t)
     ((null? (cdr things))
      #t)
     (else
      (if (not (equal? (car things)
                       (cadr things)))
          #f
          (loop (cdr things)))))))


(define (same-digits? . numbers)
  (apply all-equal? (map (compose (curry apply set) digits) numbers)))

(module+ test
  (require (planet schematics/schemeunit:3))
  (check-true  (same-digits? 12 21))
  (check-true  (same-digits? 123 321 312))
  (check-false (same-digits? 12 22))
  (check-false (same-digits? 10 1)))

(define (winner? x)
  (apply
   same-digits?
   (map ((curryr *) x)(build-list 5 (compose add1 add1)))))

(let loop ([candidate 1])
  (if (winner? candidate)
      (map ((curryr *) candidate) (build-list 6 add1))
      (loop (add1 candidate))))
