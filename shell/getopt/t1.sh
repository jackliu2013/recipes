#!/bin/bash

while getopts "a:bc" arg 
# 选项后面的冒号表示该选项需要参数
# 同时把得到的选项存进参数 arg
do
        case $arg in
              a)
                  echo "a's arg:$OPTARG" #参数存在$OPTARG中
                  ;;
              b)
                  echo "b"
                  ;;
              c)
                   echo "c"
                   ;;
              ?)  #当有不认识的选项的时候arg为?
                   echo "unkonw argument"
                   exit 1
                   ;;
         esac
done
