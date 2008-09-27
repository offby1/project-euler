#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3))

(define (palindromify n)
  (let loop ([n n]
             [accum '()]
             [length 0])
      (cond
       ((palindromic? n)
        (reverse accum))
       ((= 50 length)
        #f)
       (else (let ((new (+ n (number-reverse n))))
               (loop new
                     (cons new accum)
                     (add1 length))))
          )))

(check-equal? (palindromify 47) (list 121))
(check-equal? (length (palindromify 349)) 3)
(check-equal? (palindromify 10677) #f)