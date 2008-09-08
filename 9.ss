#lang scheme

(require "coordinates.ss"
         (lib "26.ss" "srfi"))

(map
 (cut apply * <>)
 (for/fold ([triples '()])
     ([(a b) (in-coordinates-diagonally 1000)])
   (if (and (positive? a)
            (positive? b))
       (let ((c (sqrt (+ (* a a)
                         (* b b)))))
         (if (and (integer? c)
                  (= 1000 (+ a b c)))
             (cons (list a b c)
                   triples)
             triples))
       triples)))
