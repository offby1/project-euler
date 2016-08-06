#!/bin/bash

for f in *.ss
do
    printf "%s: %s\n" "$f" "$(racket "$f")"
done
