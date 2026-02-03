# Question 4 - Email Cleaner

## Task
Extract valid and invalid emails from emails.txt

Valid format: `letters_or_numbers@letters.com`
- username can have letters and numbers
- domain must be letters only  
- must end with .com

## Files
- emailcleaner.sh
- emails.txt - input
- valid.txt - valid emails (no duplicates)
- invalid.txt - invalid ones

## How to run
```bash
./emailcleaner.sh
```

Output:
```
Email Cleaning Done

Valid emails (7):
admin@company.com
alice123@domain.com
bob@test.com
john@example.com
support@help.com
user123@test.com
valid99@mail.com

Invalid emails (8):
jane.doe@company.com
invalid-email
user@domain
test@123.com
no-at-sign.com
@nodomain.com
spaces in@email.com
user@domain.org
```

## Why some are invalid
- jane.doe - has a dot in username (not allowed per question)
- test@123.com - numbers in domain
- user@domain.org - not .com
- spaces - obviously wrong

## Commands used
- `grep -E` - extended regex
- `grep -v` - invert match (get non-matching lines)
- `sort | uniq` - remove duplicates
