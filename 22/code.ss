#lang scheme

;; Convert the textual list of comma-separataed names into a normal
;; Scheme list.  It'd have been much simpler to just delete the commas
;; with a text editor, and then wrap the whole mess with a pair of
;; parens; but this is more fun.

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
