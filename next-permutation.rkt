#lang racket

(require (only-in srfi/43 vector-swap! vector-reverse!)
         rackunit)

(provide *order*)
(define *order* (make-parameter <))

;; stolen from http://en.wikipedia.org/wiki/Permutation

;; Find the largest index k such that a[k] > a[k + 1]. If no such
;; index exists, the permutation is the last permutation.
(define (step1 a)
  (let loop ([k (- (vector-length a) 2)])
    (cond
     ((negative? k)
      #f)
     (((*order*) (vector-ref a k)
         (vector-ref a (add1 k)))
      k)
     (else
      (loop
       (sub1 k))))))

;; Find the largest index l such that a[k] > a[l]. Since k + 1 is such
;; an index, l is well defined and satisfies k > l.
(define (step2 k a)
  (let loop ([l (sub1 (vector-length a))])
    (if ((*order*) (vector-ref a k)
           (vector-ref a l))
        l
        (loop (sub1 l)))))

;; Swap a[k] with a[l].
(define (step3! k l a)
  (vector-swap! a k l))

;; Reverse the sequence from a[k + 1] up to and including the final
;; element a[n].
(define (step4! k a)
  (vector-reverse! a
                   (add1 k)
                   (vector-length a)))

(provide next-permutation)
(define (next-permutation a)
  (set! a (vector-copy a))
  (let ([k (step1 a)])
    (and k
         (let ([l (step2 k a)])
           (step3! k l a)
           (step4! k a)
           a))))

(parameterize ([*order* >])
  (check-equal? (next-permutation #(1 2 3)) #f))

(parameterize ([*order* <])
  (check-equal? (next-permutation #(1 2 3)) #(1 3 2)))

(provide all-permutations)
(define (all-permutations a sink-channel)
  (thread
   (lambda ()
     (let loop ([a (list->vector (sort (vector->list a) (*order*)))])
       (when a
         (channel-put sink-channel a)
         (loop (next-permutation a))))
     (fprintf (current-error-port)
              "All permutations of ~a done~%" a)
     (channel-put sink-channel #f))))

