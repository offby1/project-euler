#lang scheme

(require (planet "aif.ss" ("schematics" "macro.plt")))

(define (is-palindrome? n)
  (let ((chars (string->list (number->string n))))
    (and (equal? chars (reverse chars))
         n)))

(first
 (sort
  (filter is-palindrome?
          (for*/fold ([products '()])
                     ([i (in-range 999 99 -1)]
                      [j (in-range 999 99 -1)])
                     (cons (* i j ) products)))

  >))

