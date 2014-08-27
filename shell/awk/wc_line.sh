#!/bin/bash

#
# 没有换行符号的时候，统计文件的行数
# NR awk 内置的环境变量 浏览的记录个数
awk 'END{print NR}' filename
