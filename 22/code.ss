#lang scheme

(require (lib "26.ss" "srfi")
         (planet schematics/schemeunit:3))

;; Convert the textual list of comma-separataed names into a normal
;; Scheme list.  It'd have been much simpler to just delete the commas
;; with a text editor, and then wrap the whole mess with a pair of
;; parens; but this is more fun.

(define *names*
  (sort
   (call-with-input-file "names.txt"
     (lambda (ip)
       (let loop ([stuff '()])
         (let ([datum (read ip)])
           (if (eof-object? datum)
               (map (lambda (thing)
                      (match thing
                        [(? string? thing)
                         thing]
                        [(list unquote thing) thing]))
                    (reverse stuff))
               (loop (cons datum stuff)))))))
   string<?))

(define (string->numbers s)
  (define base (sub1 (char->integer #\A)))
  (map (cut - <> base) (map char->integer (string->list s))))

(define (name->sum n)
  (apply + (string->numbers n)))

(check-equal? (name->sum "COLIN") 53)

(for/fold ([sum 0])
          ([(name index) (in-indexed *names*)])
  (+ sum
     (* (add1 index)
        (name->sum name))))
