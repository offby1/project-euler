#lang scheme

(require (planet "memoize.ss" ("dherman" "memoize.plt" ))
         "../coordinates.ss"
         mzlib/trace)

(define/memo (is-pentagonal? x)
  (let ((glurph (sqrt (add1 (* 24 x)))))
    (and (integer? glurph)
         (integer? (/ (add1 glurph) 6)))))

(define (happy-pair? a b)
  (and (is-pentagonal? a)
       (is-pentagonal? b)
       (is-pentagonal? (+ a b))
       (is-pentagonal? (abs (- a b)))))
;(trace happy-pair?)

;; (for/fold ([accum '()])
;;     ([i (in-range 1000)])
;;     (if (is-pentagonal? i)
;;         (cons i accum)
;;         accum))

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
        60
        (thread
         (lambda ()
           (sort
            (for/fold ([accum '()])
                ([(x y) (in-coordinates-diagonally 100000)])
                (let ((happiness (happy-pair? x y)))
                  (if happiness
                      (cons
                       (list (list x y) happiness)
                       accum)
                      accum)))
            <
            #:key last))))))
  (kill-thread ticker)
  (if result
      (printf "Hooray! ~a~%" result)
      (printf "Bummer, ran outta time~%")))
