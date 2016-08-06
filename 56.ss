#lang scheme

(require "digits.ss")

(for*/fold ([max 0])
    ([a (in-range 100)]
     [b (in-range 100)])
    (let* ((e (expt a b))
           (sum (apply + (digits e))))
      (if (< max sum)
           sum
           max)))

