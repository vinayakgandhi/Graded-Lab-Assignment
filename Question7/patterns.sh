#!/bin/bash

# classify words by vowel/consonant patterns

FILE=${1:-input.txt}

if [ ! -f "$FILE" ]; then
    echo "File not found"
    exit 1
fi

> vowels.txt
> consonants.txt
> mixed.txt

# get unique words lowercase
words=$(cat "$FILE" | tr 'A-Z' 'a-z' | tr -cs 'a-z' '\n' | grep -v '^$' | sort -u)

for word in $words; do
    # only vowels
    if echo "$word" | grep -qE '^[aeiou]+$'; then
        echo "$word" >> vowels.txt
    # only consonants
    elif echo "$word" | grep -qE '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt
    # mixed starting with consonant
    else
        first=${word:0:1}
        if echo "$first" | grep -qE '[bcdfghjklmnpqrstvwxyz]'; then
            echo "$word" >> mixed.txt
        fi
    fi
done

echo "Pattern Classification"
echo ""
echo "Vowels only ($(wc -l < vowels.txt)):"
cat vowels.txt

echo ""
echo "Consonants only ($(wc -l < consonants.txt)):"
cat consonants.txt

echo ""
echo "Mixed starting with consonant ($(wc -l < mixed.txt)):"
head -15 mixed.txt
