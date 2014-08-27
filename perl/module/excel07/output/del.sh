#!/bin/bash
#########################################################################
# File Name: del.sh
# Author: hyf
# mail: houyafeng@gmail.com
# Created Time: 2014年03月08日 星期六 17时09分14秒
#########################################################################
find /home/acer/PBC/output -name *.xls|grep -v "*.xlsm"|xargs rm

