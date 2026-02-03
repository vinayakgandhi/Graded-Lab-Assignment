/*
 * signal_handling.c
 * Demo of signal handling between parent and children
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

int got_sigterm = 0;
int got_sigint = 0;
pid_t parent_pid;

// handle SIGTERM
void sigterm_handler(int sig) {
    got_sigterm = 1;
    printf("\n[Parent] Got SIGTERM! Preparing shutdown...\n");
}

// handle SIGINT
void sigint_handler(int sig) {
    got_sigint = 1;
    printf("\n[Parent] Got SIGINT! Time to exit.\n");
}

int main() {
    pid_t child1, child2;
    
    parent_pid = getpid();
    printf("Signal Handling Demo\n");
    printf("Parent PID: %d\n\n", parent_pid);
    
    // setup handlers
    signal(SIGTERM, sigterm_handler);
    signal(SIGINT, sigint_handler);
    
    // child 1 - sends SIGTERM after 5 sec
    child1 = fork();
    if (child1 == 0) {
        printf("[Child1] Will send SIGTERM in 5 sec\n");
        sleep(5);
        printf("[Child1] Sending SIGTERM to parent\n");
        kill(parent_pid, SIGTERM);
        exit(0);
    }
    
    // child 2 - sends SIGINT after 10 sec
    child2 = fork();
    if (child2 == 0) {
        printf("[Child2] Will send SIGINT in 10 sec\n");
        sleep(10);
        printf("[Child2] Sending SIGINT to parent\n");
        kill(parent_pid, SIGINT);
        exit(0);
    }
    
    printf("Children created. Waiting for signals...\n\n");
    
    // parent runs until SIGINT
    int sec = 0;
    while (!got_sigint) {
        printf("[Parent] Running... %d sec\n", sec);
        sleep(1);
        sec++;
    }
    
    // cleanup
    wait(NULL);
    wait(NULL);
    
    printf("\nExiting gracefully.\n");
    printf("SIGTERM received: %s\n", got_sigterm ? "yes" : "no");
    printf("SIGINT received: %s\n", got_sigint ? "yes" : "no");
    
    return 0;
}
