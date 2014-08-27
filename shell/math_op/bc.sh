#!/bin/bash

:<<comment
let expr [] (()) 只能用于整数计算
浮点数计算要使用bc
comment

result=$(echo "4*0.56+(1+100)*100/2" | bc)
echo "result = $result";

result=$(echo "scale=2; 3/8" | bc) # 保持两位精度
echo "result = $result";

result=$(echo "obase=16;255" | bc) # 10进制转16进制: FF
echo "result = $result";

result=$(echo "obase=16;ibase=2;11111111" | bc)  # 16进制转2进制: FF
echo "result = $result";

result=$(echo "sqrt(100)" | bc);  # 平方根: 10
echo "result = $result";

result=$(echo "10^8" | bc); # 幂运算: 100000000
echo "result = $result";
