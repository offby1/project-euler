#lang scheme

(require (lib "26.ss" "srfi")
         mzlib/trace)

(define (multiply-sets A B)
  (if (null? A)
   '()
   (append
    (map (cut list (car A) <>) B)
    (multiply-sets (cdr A) B))))

(define (cartesian-product . sets)
  (if (null? sets)
      '()
      (foldl
       (lambda (set list)
         (apply append
                (map (cut multiply-sets set <>)
                     list)))
       (list (car sets))
       (cdr sets))))