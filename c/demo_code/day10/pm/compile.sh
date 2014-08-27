#!/bin/bash
#gcc sigprocmask.c -omain1
#gcc signalmask.c -omain
#gcc signalmask2.c -omain
#gcc sigaction.c -omain
#gcc sigaction2.c -omain
#gcc sigqueue.c -oqueue
#gcc sigprocmask2.c -omain2
gcc pipeA.c -omyA
gcc pipeB.c -omyB
gcc pipe.c -opipe
