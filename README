See http://projecteuler.net/index.php?section=problems

Note: a number of these programs use 

        (require (planet "math.ss" ("soegaard" "math.plt")))

As of August 2008 (MzScheme v4.1), that kinda fails, because there's
some code in there that uses reverse!, and that function isn't defined
by default in MzScheme (see "Immutable Pairs" at
http://docs.plt-scheme.org/release-notes/mzscheme/MzScheme_4.txt).
The workaround is easy: delete the definition of the "farey" function
at the end of
~/.plt-scheme/planet/300/4.1/cache/soegaard/math.plt/1/2/number-theory.ss
(deleting it is safe, since nothing uses it).