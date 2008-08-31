#lang scheme

;; Stolen from http://en.wikipedia.org/wiki/Permutation

;; function permutation(k, s) {
;;      var int n:= length(s); factorial:= 1;
;;      for j= 2 to n- 1 {             // compute (n- 1)!
;;          factorial:= factorial* j;
;;      }
;;      for j= 1 to n- 1 {
;;          tempj:= (k/ factorial) mod (n+ 1- j);
;;          temps:= s[j+ tempj]
;;          for i= j+ tempj to j+ 1 step -1 {
;;              s[i]:= s[i- 1];      // shift the chain right
;;          }
;;          s[j]:= temps;
;;          factorial:= factorial/ (n- j);
;;      }
;;      return s;
;;  }

(require (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3))

(define (permutation k S)
  (let ((n (vector-length S)))
    (define (s j)
      (vector-ref S (sub1 j)))
    (define (s! j x)
      (vector-set! S (sub1 j) x))
    (if (zero? n)
        S
        (let loop ((j 1)
                   (factorial (factorial (sub1 n))))
          (when (< j n)
            (let ((tempj (remainder (quotient k factorial) (+ n 1 (- j)))))
              (let ((temps (s (+ j tempj))))
                (let rotate ((i (+ j tempj)))
                  (when (<= (add1 j) i)
                    (s! i (s (sub1 i)))
                    (rotate (sub1 i))))
                (s! j temps)

                (loop (add1 j)
                      (quotient factorial (- n j))))))
          S))))

(check-equal?
 (map (lambda (n) (permutation n (build-vector 3 values))) (build-list 6 values))
 '(#(0 1 2) #(0 2 1) #(1 0 2) #(1 2 0) #(2 0 1) #(2 1 0)))

(list->string
   (map (lambda (digit)
          (integer->char (+ digit (char->integer #\0))))
        (vector->list (permutation (sub1 1000000) (build-vector 10 values)))))
