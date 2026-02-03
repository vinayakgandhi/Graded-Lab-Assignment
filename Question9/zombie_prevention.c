/*
 * zombie_prevention.c
 * Prevent zombie processes by properly cleaning up children
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

#define NUM_CHILDREN 5

// handler for SIGCHLD - cleans up terminated children
void cleanup_child(int sig) {
    int status;
    pid_t pid;
    
    // reap all terminated children
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        printf("Cleaned up child %d\n", pid);
    }
}

int main() {
    pid_t pid;
    int i;
    
    printf("Zombie Prevention Demo\n");
    printf("Parent PID: %d\n\n", getpid());
    
    // setup signal handler for SIGCHLD
    struct sigaction sa;
    sa.sa_handler = cleanup_child;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    sigaction(SIGCHLD, &sa, NULL);
    
    printf("Creating %d children...\n", NUM_CHILDREN);
    
    // create child processes
    for (i = 0; i < NUM_CHILDREN; i++) {
        pid = fork();
        
        if (pid < 0) {
            perror("fork failed");
            exit(1);
        }
        else if (pid == 0) {
            // child
            printf("Child %d (PID %d) running\n", i+1, getpid());
            sleep(i + 1);  // each child runs different time
            printf("Child %d exiting\n", i+1);
            exit(0);
        }
        else {
            printf("Created child %d with PID %d\n", i+1, pid);
        }
    }
    
    printf("\nWaiting for children to finish...\n");
    
    // parent waits
    for (i = 0; i < NUM_CHILDREN; i++) {
        wait(NULL);
    }
    
    printf("\nAll children cleaned up, no zombies!\n");
    
    return 0;
}
