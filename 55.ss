#lang scheme

(require math/number-theory
         "digits.ss"
         (planet schematics/schemeunit:3))

(define (palindromic? n)
  (= n (number-reverse n)))

(define (number-reverse n)
  (digits->number (reverse (digits n))))


(define (lychrel? n)
  (let loop ([n n]
             [iterations 1])
    (let ((new (+ n (number-reverse n))))
      (cond
       ((palindromic? new)
        #f)
       ((= 50 iterations)
        #t)
       (else
        (loop new
              (add1 iterations)))))))

(check-false (lychrel? 47))
(check-false (lychrel? 349))
(check-true (lychrel? 196))
(check-true (lychrel? 4994))
(check-true (lychrel? 10677))

(length
 (for/fold ([lychrels '()])
     [(n (in-range 10000))]
     (if (lychrel? n)
         (cons n lychrels)
         lychrels)))
