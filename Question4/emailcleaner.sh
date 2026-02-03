#!/bin/bash

# email cleaner - separates valid and invalid emails
# valid format: letters/numbers @ letters .com

INPUT="emails.txt"
VALID="valid.txt"
INVALID="invalid.txt"

if [ ! -f "$INPUT" ]; then
    echo "emails.txt not found"
    exit 1
fi

# clear output files
> "$VALID"
> "$INVALID"

# regex for valid email: alphanumeric@letters.com
pattern='^[a-zA-Z0-9]+@[a-zA-Z]+\.com$'

# get valid emails, remove dups
grep -E "$pattern" "$INPUT" | sort | uniq > "$VALID"

# get invalid ones
grep -vE "$pattern" "$INPUT" | grep -v '^$' > "$INVALID"

echo "Email Cleaning Done"
echo ""
echo "Valid emails ($(wc -l < $VALID)):"
cat "$VALID"
echo ""
echo "Invalid emails ($(wc -l < $INVALID)):"
cat "$INVALID"
