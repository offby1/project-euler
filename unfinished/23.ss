#lang scheme

(require (lib "26.ss" "srfi")
         (lib "1.ss" "srfi")
         "../coordinates.ss"
         "../divisors.ss"
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

(define (categorize n)
  (let ((sum (apply + (all-divisors-smaller-than n))))
    (cond
     ((< n sum)
      'a)                               ;abundant
     ((< sum n)
      'd)                               ;deficient
     (else
      'p                                ;perfect
      ))))

(check-equal? (categorize 12) 'a)
(check-equal? (categorize 11) 'd)
(check-equal? (categorize  6) 'p)

(define/memo (nth-abundant-number-internal n)
  (cond
   ((< n 1)
    (error "Bozo!  I want integers >= 1." n))
   ((= n 1)
    12)
   (else
    (let loop ((candidate (add1 (nth-abundant-number-internal (sub1 n)))))
      (if (eq? 'a (categorize candidate))
          candidate
          (loop (add1 candidate)))))))

;; Apparently I can't write a contract for a memoized function
(define (nth-abundant-number n)
  (nth-abundant-number-internal n))

(define (keys ht)
  (hash-map ht (lambda (k v) k)))

(define *sums-of-pairs-of-abundant-numbers*
  (let/ec return
    (for/fold ([sums-of-abundant-pairs (make-immutable-hash '())])
        ([(i j) (in-coordinates-diagonally 10000)])

      (let ((this-sum (+ (nth-abundant-number-internal (add1 i))
                         (nth-abundant-number-internal (add1 j)))))
        (when (<
               ;;50
               28123
               this-sum)
          (printf "No point going on!~n")
          (return sums-of-abundant-pairs))
        (hash-set sums-of-abundant-pairs this-sum #t)))))

(check-equal? (apply min (keys *sums-of-pairs-of-abundant-numbers*)) 24)

(let-values ([(addends sum)
              (for/fold ([not-sums '()]
                         [sum-of-not-sums 0])
                  ([candidate (in-range (add1 (apply max (keys *sums-of-pairs-of-abundant-numbers*))))])
                  (if (hash-ref *sums-of-pairs-of-abundant-numbers* candidate #f)
                      (values not-sums sum-of-not-sums)
                      (values (cons candidate not-sums)
                              (+ candidate sum-of-not-sums))))])
  sum
)

(provide/contract
 [categorize (-> natural-number/c (cut member <> '(d p a)))]
 [nth-abundant-number (-> natural-number/c natural-number/c)])
