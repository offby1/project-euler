#lang scheme

(require math/number-theory
         rackunit
         srfi/25
         (file "read-words.ss")
         mzlib/etc)

(define (letter->number l)
  (add1
   (- (char->integer l)
      (char->integer #\a))))

(define (word-value w)
  (apply + (map (compose letter->number char-downcase) (filter char-alphabetic? (string->list w)))))

(check-equal? (word-value "SKY") 55)

(length
 (filter
  (lambda (w)
    (triangle-number? (word-value w)))
  (read-words-from
   (build-path
    (this-expression-source-directory)
    "42.txt"))))
