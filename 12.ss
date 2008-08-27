#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (except-in (lib "1.ss" "srfi") first second))

(define (sqrt n) (integer-root n 2))

(define (un-triangle x)
  (/ (sub1 (sqrt (add1 (* 8 x)))) 2))

(define *guesses*
  (map (lambda (num-divisors)
         (triangle (ceiling
             (un-triangle (factorial num-divisors)))))
       (list 499 500 501)))

(define all-exponents
  (match-lambda
   [(list prime exponent)
    (map (lambda (e)
           (expt prime e))
         (build-list (add1 exponent) values))]))

(define (multiply . lists)
  (define (foobar lst lsts)
    (if (null? lsts)
        (map list lst)
      (apply append (map (lambda (elt)
                           (map (lambda (x) (cons elt x)) lsts))
                         lst))))

  (if (null? lists)
      '()
    (foobar (car lists) (apply multiply (cdr lists)))))

(define (all-divisors-of n)
  (delete-duplicates
   (sort
    (map (lambda (nums)
           (apply * nums)) (apply multiply (map all-exponents (factorize n))))
    <)))

(define (smallest-number-with-this-many-divisors nf)
  (let loop ([candidate 1])
    (let ((num-divisors (length (all-divisors-of candidate))))
      (if (<= nf num-divisors)
          candidate
          (loop (add1 candidate))))))

;; Just plug 501 into the above and wait!!

#;
(let loop ((n 2)
           (maximum-num-divisors-seen 0)
           (record-breakers '()))
  (let* ((divisors  (all-divisors-of n))
         (nf (length divisors)))
    (if (= maximum-num-divisors-seen 502)
        (reverse record-breakers)
        (if (< maximum-num-divisors-seen nf)
            (let ((message (format "~a divisors of ~a~a"
                                   (length divisors)
                                   n
                                   (if (triangle? n)
                                       " (it's triangular!!)"
                                       ""))))
              (display message) (newline)
              (loop (add1 n)
                    nf
                    (cons message record-breakers)))
            (loop (add1 n)
                  maximum-num-divisors-seen
                  record-breakers)))))

(define (count-divisors n)
  (length (all-divisors-of n)))

;; stolen from
;; http://github.com/GreatZebu/project-euler/tree/master/euler.py.  It
;; gives an answer quickly.  It's correct.  I don't understand it. I
;; hate it.
(let/ec return
  (let ((target 501))
    (let loop ((n target))
      (let ((last_divisors (count-divisors (sub1 n))))
        (let ((divisors (count-divisors n)))
          (when (<= target (- (* divisors last_divisors)
                              (max divisors last_divisors)))
            (printf "Trying ~a * ~a / 2~%" (sub1 n) n)
            (let ((triangle (/ (* n (sub1 n)) 2)))
              (let ((f (count-divisors triangle)))
                (when (<= f target)
                  (printf "only ~a divisors, continuing...~%" f)
                  (loop (add1 n))))
              (printf "The first triangular number with at least ~a divisors is ~a~%"
                      target triangle)
              (printf "~a~%" n)
              (return triangle)))
          (loop (add1 n)))))))
