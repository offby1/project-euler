#! /bin/sh
#| Hey Emacs, this is -*-scheme-*- code!
exec racket "$0"
|#

#lang scheme

(require mzlib/etc
         racket/system)

(for ([prog
       (fold-files
        (lambda (obj flavor accum)
          (case flavor
            ((file)
             (if (regexp-match #rx"[0-9]+(/code)?\\.ss$" obj)
                 (cons obj accum)
                 accum))
            ((dir)
             (if (regexp-match #rx"/unfinished$" obj)
                 (values accum #f)
                 accum))))
        '()
        (this-expression-source-directory))])
  (printf "~a~%" prog)
  (time (system (format "racket ~a" prog)))
  (newline))
