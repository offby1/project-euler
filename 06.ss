#lang scheme

(define (diff . nums)
  (let ((sum-of-squares (apply + (map (lambda (n)
                                        (* n n))
                                      nums)))
        (square-of-sums (expt (apply + nums) 2)))
    (- square-of-sums sum-of-squares)))

(apply diff (build-list 100 add1))
