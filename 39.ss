#lang scheme

(require (lib "26.ss" "srfi")
         (lib "1.ss" "srfi")
         "../coordinates.ss"
         "../divisors.ss"
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

(define (sqr x)
  (* x x))

(define (hash-append table key value)
  ;; I wonder if I should use "lset-adjoin" instead of "cons"
  (hash-set table key (cons value (hash-ref table key '()))))

(define (summarize triples)
  ;; sanity check
  (check-true (apply = (map (cut apply + <>) triples)))
  (printf "perimeter ~a has ~a solutions:~%"
          (apply + (first triples))
          (length triples))
  (for ([trip (in-list triples)])
    (display trip)
    (newline)))

(summarize
 (for/fold ([winning-triple-list '()])
     ([(candidate-perimeter candidate-triples)
       (in-hash
        (for*/fold ([triples-by-perimeter (make-immutable-hash '())])
            ([(a b) (in-coordinates-diagonally 1000)]
             ;; come up with some guesses for c

             [c (in-range (add1 (max a b)) (ceiling (* 3/2 (max a b))))])

            (let ((perimeter  (+ a b c)))
              (if (and (< perimeter 1000)
                       (equal? (sqr c)
                               (+ (sqr a)
                                  (sqr b))))
                  (hash-append triples-by-perimeter perimeter (list a b c))
                  triples-by-perimeter))))])
     (if (< (length winning-triple-list) (length candidate-triples))
         candidate-triples
         winning-triple-list)))
