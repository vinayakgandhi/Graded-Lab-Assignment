#!/bin/bash

# text metrics - find word stats

FILE="input.txt"

if [ ! -f "$FILE" ]; then
    echo "input.txt not found"
    exit 1  
fi

echo "Analyzing: $FILE"
echo ""

# get all words, lowercase, one per line
words=$(cat "$FILE" | tr 'A-Z' 'a-z' | tr -cs 'a-z' '\n' | grep -v '^$')

# find longest
longest=$(echo "$words" | awk '{ print length, $0 }' | sort -rn | head -1 | cut -d' ' -f2)
echo "Longest word: $longest (${#longest} chars)"

# find shortest
shortest=$(echo "$words" | awk 'length>0 { print length, $0 }' | sort -n | head -1 | cut -d' ' -f2)
echo "Shortest word: $shortest (${#shortest} chars)"

# count unique
unique=$(echo "$words" | sort | uniq | wc -l)
echo "Unique words: $unique"

# average length
total_chars=0
total_words=0
for w in $words; do
    len=${#w}
    total_chars=$((total_chars + len))
    total_words=$((total_words + 1))
done

avg=$(echo "scale=2; $total_chars / $total_words" | bc)
echo "Avg word length: $avg"
