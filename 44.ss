#lang racket

(require (only-in math/number-theory pentagonal-number pentagonal-number?))

(define (check-pair j k)
  (let* ([P_j (pentagonal-number j)]
         [P_k (pentagonal-number k)]
         [sum  (+ P_j P_k)]
         [abs-diff (abs (- P_j P_k))])
    
    (and (pentagonal-number? sum)
         (pentagonal-number? abs-diff)
         (list j P_j k P_k abs-diff))
    ))


(module+ main
  (time
   (let/ec return
     (for* ([j (in-range 1 100000)]
            [k (in-range 1 j)])

       (define winner (check-pair j k))
       (when winner
         (apply printf "P_~a (~a) and P_~a (~a) are pentagonal, their sum and difference (~a) are also pentagonal~%"
                winner)
         (return))
       ))))
