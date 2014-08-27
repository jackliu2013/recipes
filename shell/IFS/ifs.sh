#!/bin/bash

:<<comm
IFS:Internal Field Separator ; 默认的IFS值为：空白（空格，tab和新行）
comm

data="name,sex,rollno,location";
oldIFS=$IFS # 暂时保存老的分隔符
IFS=,       # 设置新的分隔符为','
for item in $data; do
   echo $item;
done
IFS=$oldIFS  # 重置回来IFS

