#!/bin/bash
if [ $# -lt 3 ]
then
	echo "$#\n";
#	echo "算术表达式输入错误\n";
else
	num1=$1;
	opera=$2;
	num2=$3;
	#echo "$1\t$2\t$3\n";
	case $opera in
	+) echo "$1 $opera $3 = $(($1 + $3))";;
	-) echo "$1 $opera $3 = $(($1 - $3))";;
	x) echo "$1 $opera $3 = $(($1 * $3))";;
	/) echo "$1 $opera $3 = $(($1 / $3))";;
	exit)
	esac
fi
