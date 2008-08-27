#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt"))
         (except-in (lib "1.ss" "srfi") first second))

(define (sqrt n) (integer-root n 2))

(define (un-triangle x)
  (/ (sub1 (sqrt (add1 (* 8 x)))) 2))

(define *guesses*
  (map (lambda (num-factors)
         (triangle (ceiling
             (un-triangle (factorial num-factors)))))
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

(define (all-factors-of n)
  (delete-duplicates
   (sort
    (map (lambda (nums)
           (apply * nums)) (apply multiply (map all-exponents (factorize n))))
    <)))

(define (smallest-number-with-this-many-factors nf)
  (let loop ([candidate 1])
    (let ((num-factors (length (all-factors-of candidate))))
      (if (<= nf num-factors)
          candidate
          (loop (add1 candidate))))))

;; Just plug 501 into the above and wait!!

#;
(let loop ((n 2)
           (maximum-num-factors-seen 0)
           (record-breakers '()))
  (let* ((factors  (all-factors-of n))
         (nf (length factors)))
    (if (= maximum-num-factors-seen 502)
        (reverse record-breakers)
        (if (< maximum-num-factors-seen nf)
            (let ((message (format "~a factors of ~a~a"
                                   (length factors)
                                   n
                                   (if (triangle? n)
                                       " (it's triangular!!)"
                                       ""))))
              (display message) (newline)
              (loop (add1 n)
                    nf
                    (cons message record-breakers)))
            (loop (add1 n)
                  maximum-num-factors-seen
                  record-breakers)))))

(define (count-factors n)
  (length (all-factors-of n)))

;; stolen from
;; http://github.com/GreatZebu/project-euler/tree/master/euler.py.  It
;; gives an answer quickly.  It's correct.  I don't understand it. I
;; hate it.
(let/ec return
  (let ((target 501))
    (let loop ((n target))
      (let ((last_factors (count-factors (sub1 n))))
        (let ((factors (count-factors n)))
          (when (<= target (- (* factors last_factors)
                              (max factors last_factors)))
            (printf "Trying ~a * ~a / 2~%" (sub1 n) n)
            (let ((triangle (/ (* n (sub1 n)) 2)))
              (let ((f (count-factors triangle)))
                (when (<= f target)
                  (printf "only ~a factors, continuing...~%" f)
                  (loop (add1 n))))
              (printf "The first triangular number with at least ~a factors is ~a~%"
                      target triangle)
              (printf "~a~%" n)
              (return triangle)))
          (loop (add1 n)))))))
