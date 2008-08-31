#lang scheme

(require (lib "26.ss" "srfi")
         (lib "1.ss" "srfi")
         "coordinates.ss"
         "divisors.ss"
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

(define/memo (categorize n)
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

;; a list of abundant numbers
(filter (lambda (n) (eq? 'a (categorize n))) (build-list 20 (compose add1 add1)))

(define/memo (nth-abundant-number n)
  (if (= n 1)
      12
      (let loop ((candidate (add1 (nth-abundant-number (sub1 n)))))
        (if (eq? 'a (categorize candidate))
            candidate
            (loop (add1 candidate))))))

(define *sums-of-pairs-of-abundant-numbers*
  (let/ec return
    (for/fold ([sums-of-abundant-pairs (make-immutable-hash '())])
        ([(i j) (in-coordinates-diagonally 10000)])

      (let ((this-sum (+ (nth-abundant-number (add1 i))
                         (nth-abundant-number (add1 j)))))
        (when (< 28123 this-sum)
          (printf "No point going on!~n")
          (return sums-of-abundant-pairs))
        (hash-set sums-of-abundant-pairs this-sum #t)))))

(for/fold ([sum-of-not-sums 0])
    ([candidate (in-range (apply max (hash-map *sums-of-pairs-of-abundant-numbers* (lambda (k v) k))))])
  (if (hash-ref *sums-of-pairs-of-abundant-numbers* candidate #f)
      sum-of-not-sums
      (+ candidate sum-of-not-sums)))

(provide/contract
 [categorize (-> natural-number/c (cut member <> '(d p a)))])
