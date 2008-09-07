#!/bin/sh

find *                                          \
    ! -wholename '*unfinished/*'                \
    -type f                                     \
    \( -name '[0-9]*.ss' \)                     \
    -o                                          \
    -wholename '*[0-9]*/code.ss'                \
    | sort -n | while read s
    do
        echo -n "$s: " 
        mzscheme $s
    done
