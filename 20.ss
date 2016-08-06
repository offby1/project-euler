#lang scheme

(require math/number-theory
         "digits.ss")

(apply + (digits (factorial 100)))
