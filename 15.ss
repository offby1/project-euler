#lang scheme

;; based on a hunch: the number of routes in an nxn grid is the middle
;; number in row 2n of Pascal's triangle

(/ (factorial 40) (expt (factorial 20) 2))
