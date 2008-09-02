#lang scheme

;; Convert the textual list of comma-separataed names into a normal
;; Scheme list.  It'd have been much simpler to just delete the commas
;; with a text editor, and then wrap the whole mess with a pair of
;; parens; but this is more fun.

(define (read-words-from ifn)
  (call-with-input-file ifn
    (lambda (ip)
      (let loop ([stuff '()])
        (let ([datum (read ip)])
          (if (eof-object? datum)
              (map (lambda (thing)
                     (match thing
                       ;; The first datum we read will be a string.
                       [(? string? thing)
                        thing]
                       ;; Each subsequent datum looks like (unquote
                       ;; "FRED"), because of the leading comma.
                       [(list unquote thing) thing]))
                   (reverse stuff))
              (loop (cons datum stuff))))))))

(provide/contract
 [read-words-from (-> string? (listof string?))])