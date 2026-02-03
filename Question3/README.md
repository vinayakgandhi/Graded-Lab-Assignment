# Question 3 - Student Marks Validator

## What it does
Reads marks from marks.txt and finds:
- Students who failed in exactly 1 subject
- Students who passed everything

Pass marks = 33

## Files
- validate_results.sh
- marks.txt - input data

## Sample marks.txt
```
RollNo, Name, Marks1, Marks2, Marks3
101, Alice Johnson, 78, 85, 92
102, Bob Smith, 25, 67, 88
...
```

## Run it
```bash
./validate_results.sh
```

Output:
```
Results Validation
Pass marks: 33

Failed 1 subject: Bob Smith (25, 67, 88)
Failed 1 subject: Charlie Brown (45, 30, 55)
Failed 1 subject: Helen Troy (40, 25, 55)
Passed all: Alice Johnson (78, 85, 92)
Passed all: Diana Ross (90, 88, 95)
Passed all: Edward Lee (33, 40, 50)
Passed all: George Miller (55, 60, 65)
Passed all: Ivan Drago (100, 98, 97)
Passed all: Julia Roberts (35, 35, 35)

Done
```

Bob failed only in marks1 (25 < 33), so he counts as failed in 1 subject.
Alice got all above 33 so she passed everything.
Edward got exactly 33 in one subject - still counts as pass.

## How it works
Used IFS=',' to split CSV lines. Then compared each mark with 33 using -lt (less than). Counted fails and printed based on count.
