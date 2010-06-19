#lang scheme

(define-syntax-rule (for/vector id seq body ...)
  (list->vector
   (reverse (for/list ([id seq]) body ...))))

(define (port->vector ip)
  (list->vector (port->list read ip)))

(define (vector-update! vec index xform)
  (let ([old (vector-ref vec index)])
    (vector-set! vec index (xform old))))

(define (vector-increment! vec index add)
  (vector-update! vec index (curry + add)))

(define *the-triangle*
  (call-with-input-file
      "triangle.txt"
    (lambda (ip)
      (for/vector
       line (in-lines ip)
       (port->vector (open-input-string line))))))

(for ([(row r) (in-indexed (in-vector *the-triangle* 1))])
  (let ([bigger-row  (vector-ref *the-triangle* r)])
    (for ([c (in-range (vector-length row))])
      (let ([left-child  (vector-ref bigger-row c)]
            [right-child (vector-ref bigger-row (add1 c))])
        (vector-increment! row c (max left-child right-child))))))

(vector-ref
 (vector-ref *the-triangle* (sub1 (vector-length *the-triangle*)))
 0)
