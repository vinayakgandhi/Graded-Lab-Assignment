# Question 1 - File/Directory Analyzer

## What this script does
This script checks if the argument is a file or directory and shows relevant info.

## Files
- analyze.sh - main script
- sample_file.txt - test file
- sample_dir/ - test folder with some files

## How to run

### Make it executable first
```bash
chmod +x analyze.sh
```

### Test with a file
```bash
./analyze.sh sample_file.txt
```
Output:
```
File: sample_file.txt
---
Lines: 5
Words: 20
Characters: 105
```
This shows basic file stats using wc command. Pretty straightforward.

### Test with directory
```bash
./analyze.sh sample_dir
```
Output:
```
Directory: sample_dir
---
Total files: 4
TXT files: 3
```
Used find command to count files. The -name flag filters for .txt extension.

### Error case
```bash
./analyze.sh blahblah
```
Output:
```
Error: 'blahblah' doesn't exist
```
Just checks if path exists before doing anything.

## Commands used
- `wc` - word count, with -l for lines, -w for words, -c for chars
- `find` - searches directory recursively
- `-f` and `-d` - tests if path is file or directory
