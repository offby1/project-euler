See http://projecteuler.net/index.php?section=problems

Note: a number of these programs use 

        (require (planet "math.ss" ("soegaard" "math.plt")))

As of December 2008 (MzScheme v4.1 and version 1.3 of math.plt), that
kinda fails, because number-theory.ss contains two separate "require"
forms to pull in "memoize.plt".  One of those "require" forms
specifies a package version; the other doesn't ... and since the
default version that "Planet" pulls down for the second form differs
from the version that was explicitly specified in the first form, we
see an error.  The fix is to simply delete that second form -- the one
that doesn't specify the library version:

    diff -bu /home/erich/.plt-scheme/planet/300/4.1.3/cache/soegaard/math.plt/1/3/number-theory.ss\~ /home/erich/.plt-scheme/planet/300/4.1.3/cache/soegaard/math.plt/1/3/number-theory.ss
    --- /home/erich/.plt-scheme/planet/300/4.1.3/cache/soegaard/math.plt/1/3/number-theory.ss~	2008-12-24 05:46:16.000000000 -0800
    +++ /home/erich/.plt-scheme/planet/300/4.1.3/cache/soegaard/math.plt/1/3/number-theory.ss	2008-12-24 05:57:53.000000000 -0800
    @@ -1563,11 +1563,6 @@
                                  (- count 1)))))
         (generator 1 0 0 1 n))

    -  
    -  
    -  
    -  (require (planet "memoize.ss" ("dherman" "memoize.plt")))
    -  
       (define (mediant x y)
         (/ (+ (numerator x) (numerator y))
            (+ (denominator x) (denominator y))))

    Diff finished.  Wed Dec 24 06:21:16 2008

I've opened a bug about this: http://planet.plt-scheme.org/trac/ticket/142
