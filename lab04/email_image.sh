#!/bin/sh

for x in $@;
do
    echo `display $x` >/dev/null
    echo 'Address to e-mail this image to?'
    read ea
    echo 'Message to accompany image?'
    read meg
    `echo "$meg" | mutt -s "$x" -a $x -- $ea`
done
