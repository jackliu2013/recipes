#!/bin/bash

a=1
b=2

let c=a+b # c = 3
echo "c = $c";

let d=a+b+c*2 # d = 9. 1+2+3*2 
echo "d = $d";

let d--;  # d = 8;
echo "d = $d";

let d++;  # d= 9;
echo "d = $d";

let d+=100 # d = 109
echo "d = $d";

