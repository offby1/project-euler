#lang lazy

(provide perms)
(define (delete elt seq)
  (let loop ((seq seq)
             (result '()))
    (cond
     ((null? seq)
      (reverse result))
     ((equal? elt (car seq))
      (loop (cdr seq)
            result))
     (else
      (loop (cdr seq)
            (cons (car seq)
                  result))))))
(define (perms s)

  (if (null? s)
      (list '())
      (apply append
             (map (lambda (x)
                    (map (lambda (p) (cons x p))
                         (perms (delete x s))))
                  s))))
