#!/bin/bash

# move files to backup using background processes

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

srcdir=$1

if [ ! -d "$srcdir" ]; then
    echo "Directory not found"
    exit 1
fi

backupdir="$srcdir/backup"
mkdir -p "$backupdir"

echo "Moving files to backup"
echo "Script PID: $$"
echo ""

pids=()

for file in "$srcdir"/*; do
    # skip if its the backup folder itself
    [ -d "$file" ] && continue
    [ ! -f "$file" ] && continue
    
    fname=$(basename "$file")
    
    # move in background
    mv "$file" "$backupdir/" &
    pid=$!
    pids+=($pid)
    echo "Moving $fname (PID: $pid)"
done

echo ""
echo "Waiting for all processes..."

for p in ${pids[@]}; do
    wait $p
    echo "Process $p done"
done

echo ""
echo "All files moved to $backupdir"
ls "$backupdir"
