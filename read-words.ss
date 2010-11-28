#lang scheme

;; Convert the textual list of comma-separataed names into a normal
;; Scheme list.  It'd have been much simpler to just delete the commas
;; with a text editor, and then wrap the whole mess with a pair of
;; parens; but this is more fun.

(define (read-words-from ifn)
  (call-with-input-file ifn
    (lambda (ip)
      (map (lambda (thing)
             (match thing
               ;; The first datum we read will be a string.
               [(? string? thing)
                thing]
               ;; Each subsequent datum looks like (unquote
               ;; "FRED"), because of the leading comma.
               [(list unquote thing) thing]))
           (port->list read ip)))))

(provide/contract
 [read-words-from (-> (or/c string? path?) (listof string?))])

(require rackunit)
(let ([stuff (read-words-from "42.txt")])
  (check-equal? 1786 (length stuff))
  (check-equal? "A" (car stuff)))
