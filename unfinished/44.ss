#lang scheme

(require math/number-theory)

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
            (for*/fold ([accum '()])
                ([x 100000]
                 [y x])
                (let ((a (pentagonal-number x))
                      (b (pentagonal-number y)))
                  (if (and (pentagonal-number? (+ a b))
                           (pentagonal-number? (abs (- a b))))
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
