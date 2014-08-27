#!/bin/bash

a=1;
#while [[ $a < 5 ]]; do
while [[ $a < 5 ]]; do
    echo "$a";
    ((a+=1));
    if [ $a -eq 3 ]; then
        echo "$a now is 3, break now";
        break;
    else
        echo "$a not eq 3, continue...";
    fi
done
