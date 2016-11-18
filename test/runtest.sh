#!/bin/bash

if [ $# = 0 ]; then
    echo "Usage: $(basename $0) FILE-TYPE "
    exit 1
fi

for y in $*; do
    vim -c "source test_funky.vim | :RunTest ${y}" 
done
