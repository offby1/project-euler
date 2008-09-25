#lang scheme

(require (planet "memoize.ss" ("dherman" "memoize.plt" ))
         (planet "math.ss" ("soegaard" "math.plt"))
         "../coordinates.ss")

(define ticker
  (thread (lambda ()
            (for ([i (in-naturals)])
              (when (positive? i)
                (printf " "))
              (printf "~a" i)
              (flush-output)
              (sleep 1)))))

(let ((result
       (sync/timeout/enable-break
        120
        (thread
         (lambda ()
           (sort
            (for/fold ([accum '()])
                ([(x y) (in-coordinates-diagonally 100000)])
                (let ((a (pentagonal x))
                      (b (pentagonal y)))
                  (if (and (pentagonal? (+ a b))
                           (pentagonal? (abs (- a b))))
                      (cons
                       (list (list x y)
                             (list a b) )
                       accum)
                      accum)))
            <
            #:key last))))))
  (kill-thread ticker)
  (if result
      (printf "Hooray! ~a~%" result)
      (printf "Bummer, ran outta time~%")))
