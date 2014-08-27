#!/bin/bash

if [ $# -lt 1 ]
then
    echo "请指定要分割的文件";
else
    split -a 1 -d -l 100 $1;
fi
