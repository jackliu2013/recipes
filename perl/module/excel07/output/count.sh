#!/bin/bash
#########################################################################
# File Name: count.sh
# Author: hyf
# mail: houyafeng@gmail.com
# Created Time: 2014年03月08日 星期六 14时02分03秒
#########################################################################
echo  "11Month/t1:";
ls 11Month/T1/t1|grep -v *.xlsm|wc -l
echo  "11Month/t2:";
ls 11Month/T2/t2|grep -v *.xlsm|wc -l
echo  "11Month/t3:";
ls 11Month/T3/t3|grep -v *.xlsm|wc -l
echo  "11Month/t4:";
ls 11Month/T4/t4|grep -v *.xlsm|wc -l
echo  "11Month/t5:";
ls 11Month/T5/t5|grep -v *.xlsm|wc -l
echo  "12Month/t1:";
ls 12Month/T1/t1|grep -v *.xlsm|wc -l
echo  "12Month/t2:";
ls 12Month/T2/t2|grep -v *.xlsm|wc -l
echo  "12Month/t3:";
ls 12Month/T3/t3|grep -v *.xlsm|wc -l
echo  "12Month/t4:";
ls 12Month/T4/t4|grep -v *.xlsm|wc -l
echo  "12Month/t5:";
ls 12Month/T5/t5|grep -v *.xlsm|wc -l
