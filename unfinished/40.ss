#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (except-in (lib "1.ss" "srfi") first second)
         (lib "26.ss" "srfi")
         mzlib/trace)

(define (make-histogram)
  (make-immutable-hash '()))

(define (hist-add-item histogram item)
  (hash-set histogram item (add1 (hash-ref histogram item 0))))

(for/fold ([digit-histogram (make-histogram)])
    ([i (in-range 20)])
  (for/fold ([hist digit-histogram])
      ([d (in-list (digits i))])
    (hist-add-item hist d)))