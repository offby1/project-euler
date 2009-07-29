#lang scheme

(require (planet schematics/schemeunit:3)
         srfi/26)

(define *the-triple*
  (let/ec return
    (for* ([a (in-range 1 1000)]
           [b (in-range 1 a)])
          (let ((c (sqrt (+ (* a a)
                            (* b b)))))
            (when (and (integer? c)
                       (= 1000 (+ a b c)))
              (return (list a b c)))))))

(define *the-answer* (apply * *the-triple*))
(check-equal? *the-answer* 31875000)

(display *the-answer*)
(newline)
