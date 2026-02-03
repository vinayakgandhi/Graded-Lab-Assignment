# Question 9 - Zombie Process Prevention

## What are zombies?
When a child process ends but parent doesn't call wait(), the child becomes a "zombie" - it stays in process table even though its dead.

## How to prevent
1. Use signal handler for SIGCHLD
2. Call wait() or waitpid() to clean up

## The code (zombie_prevention.c)

Main parts:

### Signal handler
```c
void cleanup_child(int sig) {
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        printf("Cleaned up child %d\n", pid);
    }
}
```
This runs automatically when any child dies. WNOHANG means dont block.

### Creating children
```c
for (i = 0; i < 5; i++) {
    pid = fork();
    if (pid == 0) {
        // child code
        sleep(i + 1);
        exit(0);
    }
}
```
Each child sleeps different amount and exits.

## Compile and run
```bash
gcc -o zombie_prevention zombie_prevention.c
./zombie_prevention
```

Expected output:
```
Zombie Prevention Demo
Parent PID: 1234

Creating 5 children...
Created child 1 with PID 1235
Child 1 (PID 1235) running
...

Waiting for children to finish...
Cleaned up child 1235
...
All children cleaned up, no zombies!
```

## Key functions
- fork() - create child process
- wait()/waitpid() - wait for child to finish
- sigaction() - setup signal handler
- WNOHANG - non-blocking wait
