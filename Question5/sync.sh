#!/bin/bash

# compare two directories

DIR1="dirA"
DIR2="dirB"

if [ ! -d "$DIR1" ] || [ ! -d "$DIR2" ]; then
    echo "dirA or dirB not found"
    exit 1
fi

echo "Comparing $DIR1 and $DIR2"
echo ""

# files only in dirA
echo "Only in $DIR1:"
for f in "$DIR1"/*; do
    fname=$(basename "$f")
    if [ ! -e "$DIR2/$fname" ]; then
        echo "  $fname"
    fi
done

echo ""

# files only in dirB
echo "Only in $DIR2:"
for f in "$DIR2"/*; do
    fname=$(basename "$f")
    if [ ! -e "$DIR1/$fname" ]; then
        echo "  $fname"
    fi
done

echo ""

# compare common files
echo "Common files:"
for f in "$DIR1"/*; do
    fname=$(basename "$f")
    if [ -e "$DIR2/$fname" ]; then
        if cmp -s "$DIR1/$fname" "$DIR2/$fname"; then
            echo "  $fname - same"
        else
            echo "  $fname - different"
        fi
    fi
done
