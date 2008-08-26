#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(define (big-sqrt n)
  (let loop ([too-small 1]
             [too-big n])
    (let* ([guess (/ (+ too-big too-small) 2)]
           [square (* guess guess)])
      (cond
       ((<= (- too-big too-small) 1)
        (round guess))
       ((< n square)
        (loop too-small guess))
       ((> n square)
        (loop guess too-big))
       (else
        (round guess))))))

(define n (/ (sub1 (big-sqrt (add1 (* 8 (factorial 502))))) 2))

(define *solution* (triangle (ceiling n)))

*solution*
