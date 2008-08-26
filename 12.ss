#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(define (number-of-factors n)
  (apply +
         (map (lambda (seq)
                (match seq [(list prime exponent) exponent]))
              (factorize n))))

(define *first-501-factors* (map (compose add1 add1) (build-list 501 values)))

(define x (apply * *first-501-factors*))

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

(define n (/ (sub1 (big-sqrt (add1 (* 8 x)))) 2))

(define *solution* (triangle (ceiling n)))
