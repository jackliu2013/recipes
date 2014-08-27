#!/bin/bash
# 对dat中含有"rule"的文件进行替换，把"rule"替换成"fp"
find ./ -name "*dat"|xargs grep -l "rule"|xargs sed -i 's/rule/fp/g'

# 把.dat文件中的所有ark0替换成wqr_c
for file in `find ./ -name "*.dat"|xargs grep -l "ark0"`; do sed -i "s/ark0/wqr_c/g" $file ; done
