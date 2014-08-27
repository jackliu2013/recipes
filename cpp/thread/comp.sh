#!/bin/bash

g++ thread-cond.cpp -othread-cond -lpthread
g++ thread-cond2.cpp -othread-cond2 -lpthread
g++ thread-sem.cpp -othread-sem -lpthread

gcc mutex.c -omutex-test -lpthread
