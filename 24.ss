#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3))

;; Stolen from someone who answered correctly; they wrote in Common
;; Lisp

(define (but-nth n lst)
  (if (= n 0)
      (cdr lst)
      (cons (car lst)
            (but-nth (- n 1) (cdr lst)))))

(define (permute n lst)
  (if (= n 0)
      lst
      (let* ((len (length lst))
             (sublen (- len 1))
             (modulus (factorial sublen)))
        (if (> n (* len modulus))
            (error 'permute "List of length ~A doesn't have ~A permutations." len n)
            (let-values (((quotient remainder) (quotient/remainder n modulus)))
              (cons (list-ref lst quotient)
                    (permute remainder (but-nth quotient lst))))))))
