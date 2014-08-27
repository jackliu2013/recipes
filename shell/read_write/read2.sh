#!/bin/bash

:<<comment
   1. `read -n 4 var` 读4个字符到变量var
   2. `read -t 2 var` 2秒超时读取
   3. `read -p "Enter choice[Y/N]: " var` 带提示符的读取
   4. `read -s -p "Enter password: "` 不回显,带提示符读取
   5. `read -d ':' var` 以':'为分隔符读取变量到var
comment
