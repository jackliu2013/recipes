#!/bin/bash
#
# worker name cnt
# wait等待所有的后台子进程全部结束后才返回
#
worker () {
    i=0;
    while [ $i -lt $2 ]; do
      ((i=i+1));
      sleep 3;
    done
    echo "[$@] completed";
}

worker 'A' 1 &
worker 'B' 2 &
worker 'C' 3 &
worker 'D' 4 &

wait
echo "all completed";
