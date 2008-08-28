#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(apply + (digits (expt 2 1000)))
