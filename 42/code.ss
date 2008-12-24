#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi")
         (file "../read-words.ss")
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
    (triangle? (word-value w)))
  (read-words-from
   (build-path
    (this-expression-source-directory)
    "words.txt"))))
