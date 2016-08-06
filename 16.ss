#lang scheme

(require math/number-theory
         "digits.ss")

(apply + (digits (expt 2 1000)))
