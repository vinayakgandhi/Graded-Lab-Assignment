# Question 8 - Background File Mover

## Task
Move files from a directory to backup/ subfolder using background processes. Show PID of each process.

## Run
First create some test files:
```bash
mkdir testdir
echo "test1" > testdir/file1.txt
echo "test2" > testdir/file2.txt
```

Then run:
```bash
./bg_move.sh testdir
```

Output:
```
Moving files to backup
Script PID: 76431

Moving file1.txt (PID: 76436)
Moving file2.txt (PID: 76439)

Waiting for all processes...
Process 76436 done
Process 76439 done

All files moved to testdir/backup
file1.txt
file2.txt
```

## How it works
- `&` at end of command runs it in background
- `$!` gives PID of last background process
- `$$` gives PID of current script
- `wait` waits for background process to finish

Stored all PIDs in array and looped through to wait for each one.

The script skips directories (like backup folder itself) using -d check.
