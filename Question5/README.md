# Question 5 - Directory Sync Checker

## What it does
Compares dirA and dirB to find:
- Files only in dirA
- Files only in dirB
- Common files with same or different content

## Folder setup
```
dirA/
  common1.txt
  common2.txt
  unique_a.txt

dirB/
  common1.txt
  common2.txt
  unique_b.txt
```

## Run
```bash
./sync.sh
```

Output:
```
Comparing dirA and dirB

Only in dirA:
  unique_a.txt

Only in dirB:
  unique_b.txt

Common files:
  common1.txt - same
  common2.txt - different
```

## Explanation
- unique_a.txt doesnt exist in dirB so its listed
- common1.txt has same content in both folders
- common2.txt exists in both but content is different

Used `cmp -s` to compare files silently. It returns 0 if files are same, non-zero if different.

Loop through files in dirA, check if they exist in dirB using -e flag.
