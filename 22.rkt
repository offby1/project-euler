#lang racket

(require srfi/26
         rackunit
         (file "read-words.ss")
         (only-in mzlib/etc this-expression-source-directory))

(define (string->numbers s)
  (define base (sub1 (char->integer #\A)))
  (map ((curryr -) base) (map char->integer (string->list s))))

(define (name->sum n)
  (apply + (string->numbers n)))

(check-equal? (name->sum "COLIN") 53)

(for/fold ([sum 0])
    ([(name index) (in-indexed (sort (read-words-from
                                      (build-path
                                       (this-expression-source-directory)
                                       "22.txt")) string<?))])
    (+ sum
       (* (add1 index)
          (name->sum name))))
