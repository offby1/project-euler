#lang scheme

(require math/number-theory)

;; nth-prime considers 2 to be prime#0, and 3 to be prime #1, so we
;; ask for the 10000th prime, even though the problem asks for the
;; 10001st.

(nth-prime 10000)
