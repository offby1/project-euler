#lang scheme

(require (lib "26.ss" "srfi")
         (planet schematics/schemeunit:3)
         (file "../read-words.ss")
         mzlib/etc)

(define (string->numbers s)
  (define base (sub1 (char->integer #\A)))
  (map (cut - <> base) (map char->integer (string->list s))))

(define (name->sum n)
  (apply + (string->numbers n)))

(check-equal? (name->sum "COLIN") 53)

(for/fold ([sum 0])
          ([(name index) (in-indexed (sort (read-words-from
                                            (build-path
                                             (this-expression-source-directory)
                                             "names.txt")) string<?))])
  (+ sum
     (* (add1 index)
        (name->sum name))))
