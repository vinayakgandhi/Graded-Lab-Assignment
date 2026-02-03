#!/bin/bash

# log analyzer script
# reads log file and counts different message types

if [ $# -ne 1 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

logfile=$1

if [ ! -f "$logfile" ]; then
    echo "Error: file '$logfile' not found"
    exit 1
fi

if [ ! -r "$logfile" ]; then
    echo "Error: cant read file"
    exit 1
fi

echo "Log Analysis for: $logfile"
echo "---"

# count total lines
total=$(wc -l < "$logfile")
echo "Total entries: $total"

# count each type
info=$(grep -c " INFO " "$logfile")
warn=$(grep -c " WARNING " "$logfile")
err=$(grep -c " ERROR " "$logfile")

echo "INFO: $info"
echo "WARNING: $warn"
echo "ERROR: $err"

echo ""
echo "Last ERROR:"
grep " ERROR " "$logfile" | tail -1

# make report file
today=$(date +%Y-%m-%d)
report="logsummary_${today}.txt"

echo "Log Report - $today" > "$report"
echo "File: $logfile" >> "$report"
echo "" >> "$report"
echo "Total: $total" >> "$report"
echo "INFO: $info" >> "$report"
echo "WARNING: $warn" >> "$report"
echo "ERROR: $err" >> "$report"

echo ""
echo "Report saved: $report"
