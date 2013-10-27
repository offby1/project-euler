#lang racket
; Hey Emacs, this is -*-scheme-*- code!

(require (planet wmfarr/permutations:1:2/permutations))

(define (digits->number digits)
  (for/fold ([sum 0])
      ([d digits])
      (+ d (* 10 sum))))

(define (try-permutation digits)
  (for ([left-index (range 1 (sub1 (vector-length digits)))])
    (let-values ([(left-v rest) (vector-split-at digits left-index)])
      (for ([middle-index (range 1 (sub1 (vector-length rest)))])
        (let-values ([(middle-v right-v) (vector-split-at rest middle-index)])
          (define left   (digits->number   left-v))
          (define middle (digits->number middle-v))
          (define right  (digits->number  right-v))
          (define is-solution?  (= right (* left middle )))
          (when  is-solution?
            (printf "~a * ~a = ~a!!~%" left middle right)))
        ))))


(let loop ([digits (for/vector ([x(in-range 1 10)]) x)])
  (when digits
    (try-permutation digits)
    (loop (permutation-next! digits)))
  )
