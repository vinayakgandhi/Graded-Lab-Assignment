# Question 6 - Text File Metrics

## Task
Analyze input.txt and show:
- Longest word
- Shortest word
- Average word length
- Unique word count

## Run
```bash
./metrics.sh
```

Output:
```
Analyzing: input.txt

Longest word: capabilities (12 chars)
Shortest word: a (1 chars)
Unique words: 51
Avg word length: 5.16
```

## How it works
First I extract all words using tr command:
- `tr 'A-Z' 'a-z'` - convert to lowercase
- `tr -cs 'a-z' '\n'` - replace non-letters with newlines

Then use awk to print length with each word, sort by length to find longest/shortest.

For average, loop through all words, add up lengths, divide by count using bc calculator.

The unique count uses `sort | uniq | wc -l` which is a common pattern.
