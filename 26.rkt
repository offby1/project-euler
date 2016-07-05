#lang racket
(require (only-in math coprime? with-modulus mod= mod+ mod*))

;; Adapted from
;; https://planet.racket-lang.org/package-source/soegaard/math.plt/1/5/number-theory.ss
(define (order g n)
  (if (not (coprime? g n))
      (error "In (order g n) the g and n must me coprime")
      (with-modulus n
                    (let loop ([k 1]
                               [a g])
                      (if (mod= a 1)
                          k
                          (loop (mod+ k 1) (mod* a g)))))))

(define (length-of-repeated-fraction denom)
  (if (coprime? 10 denom)
      (order 10 denom)
      0))

(for/fold ([winner '(0 . 0)])
    ([candidate (in-range 2 1000)])
    (let ([l (length-of-repeated-fraction candidate)])
      (if (< (cdr winner) l)
          (cons candidate l)
          winner)))
