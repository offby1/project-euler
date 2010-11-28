#lang racket

(require (only-in srfi/43 vector-swap! vector-reverse!)
         (only-in (planet soegaard/math/math) prime? digits->number))

;; stolen from http://en.wikipedia.org/wiki/Permutation

;; Find the largest index k such that a[k] > a[k + 1]. If no such
;; index exists, the permutation is the last permutation.
(define (step1 a)
  (let loop ([k (- (vector-length a) 2)])
    (cond
     ((negative? k)
      #f)
     ((> (vector-ref a k)
         (vector-ref a (add1 k)))
      k)
     (else
      (loop
       (sub1 k))))))

;; Find the largest index l such that a[k] > a[l]. Since k + 1 is such
;; an index, l is well defined and satisfies k > l.
(define (step2 k a)
  (let loop ([l (sub1 (vector-length a))])
    (if (> (vector-ref a k)
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

(define (next-permutation a)
  (set! a (vector-copy a))
  (let ([k (step1 a)])
    (and k
         (let ([l (step2 k a)])
           (step3! k l a)
           (step4! k a)
           a))))

(define (all-permutations a sink-channel)
  (thread
   (lambda ()
     (let loop ([a (list->vector (sort (vector->list a) >))])
       (when a
         (channel-put sink-channel a)
         (loop (next-permutation a))))
     (fprintf (current-error-port)
              "All permutations of ~a done~%" a)
     (channel-put sink-channel #f))))

;; Start computing all permutations of the nine non-zero digits.
(define *the-channel* (make-channel))

;; I originally tried 1 through 9 and 1 through 8; those failed to
;; return anything.  Thank God I was able to avoid checking numbers
;; that contained zeroes; that'd have taken me all century.
(define t  (all-permutations (vector 1 2 3 4 5 6 7) *the-channel*))

(let loop ()
  (let ([perm (channel-get *the-channel*)])
    (if (not perm)
      "Oops."
    (let ([candidate (digits->number (vector->list perm))])
      (cond
       ((prime? candidate)
        candidate)
       (else
        (loop)))))))
