#lang scheme
(require (planet schematics/schemeunit:3))

(define *the-triangle*
  (vector
   (vector 75)
   (vector 95 64)
   (vector 17 47 82)
   (vector 18 35 87 10)
   (vector 20 04 82 47 65)
   (vector 19 01 23 75 03 34)
   (vector 88 02 77 73 07 63 67)
   (vector 99 65 04 28 06 16 70 92)
   (vector 41 41 26 56 83 40 80 70 33)
   (vector 41 48 72 33 47 32 37 16 94 29)
   (vector 53 71 44 65 25 43 91 52 97 51 14)
   (vector 70 11 33 28 77 73 17 78 39 68 17 57)
   (vector 91 71 52 38 17 14 91 43 58 50 27 29 48)
   (vector 63 66 04 68 89 53 67 30 73 16 69 87 40 31)
   (vector 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23)
   ))

(define-struct coords (row col) #:prefab)

(define (lookup c)
  (vector-ref (vector-ref *the-triangle* (coords-row c)) (coords-col c)))
(define (replace! c new-val)
  (vector-set! (vector-ref *the-triangle* (coords-row c)) (coords-col c) new-val))

(define (left-child c)
  (lookup
   (make-coords
    (add1 (coords-row c))
    (coords-col c))))

(define (right-child c)
  (lookup
   (make-coords
    (add1 (coords-row c))
    (add1 (coords-col c)))))

(define (cell-value c)
  (if (number? c)
      c
      (car c)))



(let ((c (make-coords 3 2)))
  (check-equal? (lookup      c) 87)
  (check-equal? (left-child  c) 82)
  (check-equal? (right-child c) 47)

  (replace! c 9876)

  (check-equal? (lookup      c) 9876)
  (check-equal? (left-child  c) 82)
  (check-equal? (right-child c) 47)

  (replace! c 87))


(for ([row (in-range (- (vector-length *the-triangle*) 2)
                      -1
                      -1)])
  (for ([column (in-range 0 (add1 row))])
    (let ([c (make-coords row column)])
      (replace! c (if (< (cell-value (right-child c))
                         (cell-value (left-child c)))
                      (cons (+
                             (cell-value (lookup c))
                             (cell-value (left-child c))) #\/)
                      (cons (+
                             (cell-value (lookup c))
                             (cell-value (right-child c))) #\\))))))
*the-triangle*
