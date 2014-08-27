#!/bin/bash

# man seq 查看seq使用
for a in `seq 1 10`      # 1 到 10，每次增加1
do
	echo $a
done

# man seq 查看seq使用
for a in `seq 1 2 10`    # 1 到 10， 每次增加2
do
	echo $a
done
