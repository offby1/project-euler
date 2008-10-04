#lang scheme

(require srfi/26
         (except-in srfi/1 first second)
         "../coordinates.ss"
         (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         mzlib/trace)

(define (bigger-primes n)
  (for/fold ([winners '()])
      ((right (list 2 3 5 7))
       (left  (list 2 3 5 7)))
      (let* ((short (append n (list right)))
             (long (cons left short)))
        (let ((winners (if (prime? (digits->number short))
                           (cons short winners)
                           winners)))
          (if (prime? (digits->number long))
              (cons long winners)
              winners)))))

(define (sort-digit-lists digit-lists)
  (sort digit-lists
   <
   #:key digits->number))

(remove-duplicates
 (sort
  (append-map (lambda (seqs)
                (map digits->number seqs))
              (let loop ((seed '((2) (3) (5) (7)))
                         (prev '())
                         (accum '()))
                (if (and (not (null? seed))
                         (or (null? accum)
                             (< (length prev)
                                (length accum))))
                    (loop (remove-duplicates (sort-digit-lists (append-map bigger-primes seed)))
                          accum
                          (cons seed accum))
                    accum)))
  <))
