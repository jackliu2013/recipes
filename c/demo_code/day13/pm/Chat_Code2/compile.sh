#!/bin/bash
gcc chatServer.c -oserver -lpthread
gcc chatClient.c -oclient -lpthread
