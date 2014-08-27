#!/bin/bash

# 1.将多行输入转换成单行输出
cat example.txt | xargs 

# 2.单行输入转换为多行输出
cat example_2.txt | xargs | xargs -n 3

# 3. -d 指定定界符
echo "splitXsplitXsplitXsplit" | xargs -d X -n 2

# 4. xargs提取参数传递给程序
# -n k  : 一次提取k个参数
# -I {} : 参数替代
cat args.txt | xargs -n 1 echo "hello" 
cat args.txt | xargs -n 5 echo "hello" 
cat args.txt | xargs | xargs -n 2 -I {} echo {} " => hello" 
