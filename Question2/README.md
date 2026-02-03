# Question 2 - Log Analyzer

## About
Script to analyze log files and count INFO/WARNING/ERROR messages.

## Files
- log_analyzer.sh - the script
- sample.log - sample log file for testing
- logsummary_*.txt - generated report

## Running

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh sample.log
```

Output:
```
Log Analysis for: sample.log
---
Total entries: 10
INFO: 4
WARNING: 3
ERROR: 3

Last ERROR:
2025-01-12 10:21:05 ERROR Database connection failed

Report saved: logsummary_2026-02-03.txt
```

The script reads the log file line by line and uses grep to count how many times each log level appears. grep -c gives count directly which is handy.

For finding the last error, I used `grep | tail -1` to get only the last matching line.

The report file is named with current date using the date command.

## What I learned
- grep is really useful for searching patterns
- grep -c counts matches
- tail -1 gives last line
- Can use >> to append to files
