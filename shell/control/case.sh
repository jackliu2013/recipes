#!/bin/bash

<<comment

comment

echo -n "enter a number from 1 to 5 :";
read ANS;
case $ANS in
    1) echo "you select 1";
        ;;
    2) echo "you select 2";
        ;;
    3) echo "you select 3";
        ;;
    4) echo "you select 4";
        ;;
    5) echo "you select 5";
        ;;
    *) echo "`basename $0`: This is not between 1 and 5" >&2;
        exit 1;
        ;;
esac
