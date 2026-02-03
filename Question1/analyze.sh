#!/bin/bash

# analyze.sh - script to analyze files or directories
# takes one argument - either file or folder path

if [ $# -ne 1 ]; then
    echo "Error: need exactly one argument"
    echo "Usage: $0 <path>"
    exit 1
fi

path=$1

# check if path exists
if [ ! -e "$path" ]; then
    echo "Error: '$path' doesn't exist"
    exit 1
fi

# if its a file
if [ -f "$path" ]; then
    echo "File: $path"
    echo "---"
    
    lines=$(wc -l < "$path")
    words=$(wc -w < "$path")
    chars=$(wc -c < "$path")
    
    echo "Lines: $lines"
    echo "Words: $words"  
    echo "Characters: $chars"

# if its a directory
elif [ -d "$path" ]; then
    echo "Directory: $path"
    echo "---"
    
    total=$(find "$path" -type f | wc -l)
    txtfiles=$(find "$path" -name "*.txt" -type f | wc -l)
    
    echo "Total files: $total"
    echo "TXT files: $txtfiles"
else
    echo "Error: not a file or directory"
    exit 1
fi
