#lang scheme

(for/fold ([sum 0])
    ((i (in-range 0 1000 )))
  (+ sum
     (if (or (zero? (remainder i 3))
             (zero? (remainder i 5)))
         i
         0)))
