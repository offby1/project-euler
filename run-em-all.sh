#!/bin/bash

for f in [0-9]*.ss [0-9]*.rkt
do
    echo -n "${f}: "
    racket "${f}"
done

for f in [0-9]*.py
do
    echo -n "${f}: "
    PATH=/usr/local/bin:$PATH python3 "$f"
done

for d in */
do
    (
        cd $d
        if [ -e runme.sh ]
        then
            ./runme.sh
        fi
    )
done
