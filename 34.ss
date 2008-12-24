#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3))

(define (whatsit n)
  (apply + (map factorial (digits n))))

(check-equal? (whatsit 145) 145)

(apply
 +
 (filter (lambda (n)
           (and (not (member n '(1 2)))
                (= n (whatsit n))))
         (build-list 100000 values)))
