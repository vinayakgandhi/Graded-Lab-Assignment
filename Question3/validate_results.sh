#!/bin/bash

# validate student marks
# format: RollNo, Name, Marks1, Marks2, Marks3
# pass marks = 33

PASS=33
FILE="marks.txt"

if [ ! -f "$FILE" ]; then
    echo "marks.txt not found!"
    exit 1
fi

echo "Results Validation"
echo "Pass marks: $PASS"
echo ""

failed_one=0
passed_all=0

# skip first line (header)
tail -n +2 "$FILE" | while IFS=',' read roll name m1 m2 m3; do
    # trim spaces
    m1=$(echo $m1 | tr -d ' ')
    m2=$(echo $m2 | tr -d ' ')
    m3=$(echo $m3 | tr -d ' ')
    name=$(echo $name | xargs)
    
    fail_count=0
    
    [ $m1 -lt $PASS ] && ((fail_count++))
    [ $m2 -lt $PASS ] && ((fail_count++))
    [ $m3 -lt $PASS ] && ((fail_count++))
    
    if [ $fail_count -eq 1 ]; then
        echo "Failed 1 subject: $name ($m1, $m2, $m3)"
    elif [ $fail_count -eq 0 ]; then
        echo "Passed all: $name ($m1, $m2, $m3)"
    fi
done

echo ""
echo "Done"
