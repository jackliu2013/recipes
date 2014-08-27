#!/bin/bash

:<<comment
tee 输出到标准输出和文件
comment

# tee /tmp/t1 - 输出到/tmp/t1文件，标准输出。在tee中，'-'意味标准输出
echo "this is a test" | tee /tmp/t1 -
