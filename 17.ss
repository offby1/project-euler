#lang scheme

(require (planet "numspell.ss" ("neil" "numspell.plt")))

(define (tweaked-number->english n)
  (let ((odds (remainder n 100)))
    (format
     "~a~a"
     (number->english n)
     (if (or (< n 100)
             (zero? odds))
         ""
         " and"))))

(define (letter-count s)
  (length (filter char-alphabetic? (string->list s))))

(foldl
 (lambda (string accum)
   (+ accum (letter-count string)))
 0
 (for/list ((x (in-range 1 1001)))
   (tweaked-number->english x)))