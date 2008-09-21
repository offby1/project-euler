#lang scheme

(require srfi/26
         (except-in srfi/1 first second)
         "../coordinates.ss"
         (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3)
         (planet "memoize.ss" ("dherman" "memoize.plt" )))

(for/fold ([fracs '()])
    ([(i j) (in-coordinates-diagonally 100)])
  (if (or (zero? j)
          (zero? (remainder j 10))
          (>= j i)
          (< j 10)
          (< i 10))
      fracs
      (let* ((top (digits i))
             (bot (digits j))
             (common (lset-intersection equal? top bot)))
        (if (= 1 (length common))
            (let ((top (digits->number (lset-difference equal? top common)))
                  (bot (digits->number (lset-difference equal? bot common))))
              (if (or (zero? bot)
                      (not (= (/ top bot)
                              (/ i j))))
                  fracs
                  (begin
                    (printf "~a / ~a~%" i j)
                   (cons
                   (/ top bot)
                   fracs))))
            fracs))))

