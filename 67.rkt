#lang racket

(define *the-triangle*
  (call-with-input-file "67.txt"
    (lambda (ip)
      (for/vector
       ([line (in-lines ip)])
       (list->vector (port->list read (open-input-string line)))))))

(define (vector-update! vec index xform)
  (vector-set! vec index (xform (vector-ref vec index))))

(define (vector-increment! vec index delta)
  (vector-update! vec index (curry + delta)))

(for ([(row r) (in-indexed (in-vector *the-triangle* 1))])
  (let ([bigger-row  (vector-ref *the-triangle* r)])
    (for ([c (in-range (vector-length row))])
      (let ([left-child  (vector-ref bigger-row c)]
            [right-child (vector-ref bigger-row (add1 c))])
        (vector-increment! row c (max left-child right-child))))))

(vector-ref
 (vector-ref *the-triangle* (sub1 (vector-length *the-triangle*)))
 0)
