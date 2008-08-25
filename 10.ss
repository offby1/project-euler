#lang scheme
(require (planet "math.ss" ("soegaard" "math.plt")))

(time
 (let loop ([accum 0]
            [this-prime 2])
   (if (< this-prime 2000000)
       (loop (+ accum this-prime)
             (next-prime this-prime))
       accum)))

