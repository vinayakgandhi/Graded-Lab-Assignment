# Question 10 - Signal Handling

## What signals?
- SIGTERM - termination request (can be handled)
- SIGINT - interrupt (like Ctrl+C)

## Program flow
1. Parent starts and runs forever
2. Child1 sends SIGTERM after 5 seconds
3. Child2 sends SIGINT after 10 seconds
4. Parent handles both differently and exits

## The code

### Handlers
```c
void sigterm_handler(int sig) {
    printf("Got SIGTERM!\n");
}

void sigint_handler(int sig) {  
    got_sigint = 1;  // this will stop the while loop
}
```

### Children
```c
// child1
sleep(5);
kill(parent_pid, SIGTERM);

// child2
sleep(10);
kill(parent_pid, SIGINT);
```

## Compile and run
```bash
gcc -o signal_handling signal_handling.c
./signal_handling
```

Output:
```
Signal Handling Demo
Parent PID: 1234

[Child1] Will send SIGTERM in 5 sec
[Child2] Will send SIGINT in 10 sec
Children created. Waiting for signals...

[Parent] Running... 0 sec
[Parent] Running... 1 sec
...
[Parent] Running... 4 sec
[Child1] Sending SIGTERM to parent

[Parent] Got SIGTERM! Preparing shutdown...
[Parent] Running... 5 sec
...
[Child2] Sending SIGINT to parent

[Parent] Got SIGINT! Time to exit.

Exiting gracefully.
SIGTERM received: yes
SIGINT received: yes
```

## Key stuff
- signal() or sigaction() to setup handlers
- kill() sends signal to process
- Global flags to communicate between handler and main code
