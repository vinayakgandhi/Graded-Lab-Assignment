# Question 7 - Word Pattern Classifier

## Task
Classify words into 3 categories:
1. vowels.txt - words with ONLY vowels (a,e,i,o,u)
2. consonants.txt - words with ONLY consonants 
3. mixed.txt - words with both, starting with consonant

Case is ignored.

## Run
```bash
./patterns.sh input.txt
```

Output:
```
Pattern Classification

Vowels only (3):
a
ae
i

Consonants only (8):
cry
dry
fly
myth
rhythm
sky
try
why

Mixed starting with consonant (21):
blue
for
going
...
```

## Explanation
Words like "a" and "i" only have vowels.

Words like "myth", "rhythm", "sky" have no vowels at all (y is not counted as vowel here).

Words like "hello" have both vowels and consonants and start with 'h' which is consonant, so they go to mixed.txt.

Used regex patterns:
- `^[aeiou]+$` - only vowels
- `^[bcdf...]+$` - only consonants

The ${word:0:1} syntax gets first character to check if it starts with consonant.
