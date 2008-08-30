#lang scheme

(require (planet "math.ss" ("soegaard" "math.plt")))

(apply + (digits (factorial 100)))
