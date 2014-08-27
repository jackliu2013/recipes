#!/bin/bash
# 把CSV文件中日期的/分隔符号替换为-
    db2 <<!
connect to zdb_dev user ypinst using ypinst
delete from  sktx_gdh_data
!
for file in `ls *.csv`;
do
 #   echo $file
    # 把日期中的 / 替换为 -
    sed -i 's/\//-/g' $file;
    db2 <<!
connect to zdb_dev user ypinst using ypinst
import from $file of del insert into sktx_gdh_data
!
done

perl rj_unhead.t
