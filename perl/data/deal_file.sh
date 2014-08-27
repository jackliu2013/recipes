#!/bin/bash
###########################################
#	1.在导入数据之前先把数据清空
#	2.对文件中日期的数据进行替换处理
#	3.执行db2中的import命令把数据导入库表
#	4.执行func.pl把库表中出金数据生成文件
###########################################

######## 1 #########
db2 <<!
connect to zdb_dev user ypinst using ypinst
delete from source_jsck
delete from sktx_gdh_data
!

######## 2 导入出金类交易数据 #########
for file in `find ./ -name '*cjjy*.csv'`
do
	#echo $file ;
	# 把日期中的 / 替换为 -
	sed -i 's/\//-/g' $file ;
	########### 3 ############
db2 <<!
connect to zdb_dev user ypinst using ypinst
import from $file of del insert into source_jsck
!
done

######## 2 导入入金类交易数据 #########
for file in `find ./ -name '*rjjy*.csv'`;
do
    #echo $file
    # 把日期中的 / 替换为 -
    sed -i 's/\//-/g' $file;
	########### 3 ############
    db2 <<!
connect to zdb_dev user ypinst using ypinst
import from $file of del insert into sktx_gdh_data
!
done

############# 4 #############
perl func.pl
perl rj_unhead.t
