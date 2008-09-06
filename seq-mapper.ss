#lang scheme

(require "coordinates.ss"
         (planet schematics/schemeunit:3))

(define (transformed-sequence orig-sequence value-transformer)
  (define-values (more? next!) (sequence-generate orig-sequence))

  ;; our state is (cons (list value1 value2 ...) orig-sequence)
  (make-do-sequence
   (lambda ()
     (values

      ;; state->value(s)
      (match-lambda
       [(cons current-values original-sequence)
        (apply values (value-transformer current-values))])

      ;; current state->next-state
      (lambda (ignored) (cons (call-with-values next! list) orig-sequence))

      ;; initial state
      (cons (call-with-values next! list) orig-sequence)

      ;; not-last?  state->bool
      (lambda (ignored) (more?))

      ;; not-last?  values(s)->bool
      (lambda (x y) #t)

      ;; not-last? (-> state val ... bool)
      (lambda (t x y) #t)))))

(check-equal?
 (for/list ([(i j)  (in-coordinates-diagonally 3)])
   (list i j))
 '((0 0) (1 0) (2 0) (1 1)))

(define offset-point
  (match-lambda
   [(list x y)
    (list (add1 x)
          (add1 y))]))

(check-equal?
 (for/list ([(i j)  (transformed-sequence (in-coordinates-diagonally 3) offset-point)])
   (list i j))
 '((1 1) (2 1) (3 1) (2 2)))
