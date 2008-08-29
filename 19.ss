#lang scheme

(require (lib "19.ss" "srfi"))

(let loop ([first-of-the-month-sundays 0]
           [today (date->time-utc
                   ;; Midnight (at the beginning of) January 1, 1901,
                   ;; UTC.
                   (make-date 0 0 0 0 1 1 1901 0))])
  (let ((date (time-utc->date today)))
    (if (< 2000 (date-year date))
        first-of-the-month-sundays
        (loop (+ first-of-the-month-sundays
                 (if (and
                      (zero? (date-week-day date)) ;Sunday?
                      (= 1 (date-day date)) ;1st of the month?
                      ) 1 0))
                 (add-duration today (make-time 'time-duration 0 (* 24 60 60)))))))

