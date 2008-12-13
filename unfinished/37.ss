#lang scheme

(require srfi/1
         srfi/26
         (except-in srfi/1 first second)
         "../coordinates.ss"
         (except-in (planet "math.ss" ("soegaard" "math.plt")) first
                                                               second)
         (planet schematics/schemeunit:3)
         mzlib/trace)

(define (bigger-primes n [left? #t])
  (let ((n (digits n)))
    (for/fold ([winners '()])
        ((more (list 2 3 5 7)))
        (let ((longer (if left? (cons more n) (append n (list more)))))
          (if (every (compose prime? digits->number) ((if left? all-cars all-cdrs) longer))
              (cons (digits->number longer) winners)
              winners)))))

(define more-internal
  (match-lambda
   [(list ns ...)
    (append-map more-internal ns)]
   [n
    (append (bigger-primes n #t)
              (bigger-primes n #f))]))

(define more
  (lambda args
    (remove-duplicates
     (sort
      (apply more-internal args)
      <))))

(define (maybe-grow-list l)
  (let ((new (remove-duplicates (sort (append-map more l)
                                      < ))))
    (and (not (null? new))
         (remove-duplicates (sort (append l new) <)))))

(define (all-cdrs seq)
  (let loop ((seq seq)
             (accum '()))
    (if (null? seq)
        (reverse accum)
        (loop (cdr seq)
              (cons seq accum)))))

(define (all-cars seq)
  (let loop ((seq seq)
             (accum '()))
    (if (null? seq)
        accum
        (loop (drop-right seq 1)
              (cons seq accum)))))
(printf "~a~%" (more 1))
(printf "~a~%" (more (more 1)))
