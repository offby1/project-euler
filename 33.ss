#lang scheme

(require srfi/26
         (except-in srfi/1 first second)
         "coordinates.ss"
         (planet "math.ss" ("soegaard" "math.plt"))
         (planet schematics/schemeunit:3))

(apply
 *
 (for*/fold ([fracs '()])
     ([bot (in-range 10 100)]
      [top (in-range 10 bot)])

     (if (zero? (remainder bot 10))
         fracs
         (let* ((top-digits (digits top))
                (bot-digits (digits bot))
                (common-digits (lset-intersection equal? top-digits bot-digits)))
           (if (not (null? common-digits))
               (let ((TOP (digits->number (lset-difference equal? top-digits common-digits)))
                     (BOT (digits->number (lset-difference equal? bot-digits common-digits))))
                 (if (or (zero? BOT)
                         (zero? TOP)
                         (not (= (/ top bot)
                                 (/ TOP BOT))))
                     fracs
                     (begin
                       (printf "~a / ~a~%" top bot)
                       (cons
                        (/ top bot)
                        fracs))))
               fracs)))))
