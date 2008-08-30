#lang scheme

(require (lib "26.ss" "srfi")
         "divisors.ss"
         (planet schematics/schemeunit:3))

(define (categorize n)
  (let ((sum (apply + (all-divisors-smaller-than n))))
    (cond
     ((< n sum)
      'a)                               ;abundant
     ((< sum n)
      'd)                               ;deficient
     (else
      'p                                ;perfect
      ))))

(check-equal? (categorize 12) 'a)
(check-equal? (categorize 11) 'd)
(check-equal? (categorize  6) 'p)

;; a list of abundant numbers
(filter (lambda (n) (eq? 'a (categorize n))) (build-list 20 (compose add1 add1)))

(provide/contract
 [categorize (-> natural-number/c (cut member <> '(d p a)))])
