#!/bin/bash

if [[ "a$DB_USER" == "a" || "a$DB_PASS" == "a" || "a$DB_NAME" == "a" || "a$DB_SCHEMA" == "a" ]]; then
    echo "lack of environment variable";
    echo "DB_USER   [$DB_USER]";
    echo "DB_PASS   [$DB_PASS]";
    echo "DB_NAME   [$DB_NAME]";
    echo "DB_SCHEMA [$DB_SCHEMA]";
    exit -1;
fi

# 加载 db2 环境变量
. $HOME/sqllib/db2profile

# 数据库数据导出
dir="$HOME/back";
#dat=`date +%Y%m%d`;
dat=`date +%Y%m%d`;
backdir="$dir/$dat" ;

# 数据导出目录
mkdir -p $backdir;


:<<comment
book_xxxx表，每日全表备份
yspz_xxxx表, 每日全表备份
sum_xxxxx表，每日全表备份
其他字典表每日全备
所有sequence需要备份为 seq_xxx.dat

/db2back/YYYYMMDD/book_xxxx.ixf
/db2back/YYYYMMDD/sum_xxxx.ixf
/db2back/YYYYMMDD/seq_xxx.dat
/db2back/YYYYMMDD/xxxxxxx.ixf
comment

#########################################################
# backup database data 
#########################################################

# 备份所有的科目表
function backup_book {
    db2 -x list tables for schema $DB_SCHEMA | egrep "^BOOK" | awk '{ print $1 }' | 
    (
    	db2 connect to $DB_NAME user $DB_USER using $DB_PASS >/dev/null 2>&1 ;
    	db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;

    	while read tb ; do
            db2 " export to $backdir/$tb.ixf of ixf lobs to $backdir select * from $tb " >/dev/null 2>&1;
            if [ $? != 0 ]; then
                echo " $tb backup failed";
                exit -1 ;
            fi
        done;
        echo "books backup succeed";
    );
    return $? ;
}

# 备份所有的原始凭证表,记账凭证表及原始凭证id控制表
function backup_yspz {
    db2 -x list tables for schema $DB_SCHEMA | egrep "^YSPZ|^JZPZ|SEQ_YSPZ_CTRL" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read yspz ; do
            db2 " export to $backdir/$yspz.ixf of ixf select * from $yspz " >/dev/null 2>&1;
            if [ $? != 0 ]; then
                echo " $yspz backup failed";
                exit -1 ;
            fi
        done;
        echo "yspz backup succedd";
    );
    return $? ;
}

# 备份所有的字典表
function backup_dict {
    db2 -x list tables for schema $DB_SCHEMA | egrep -v "^SUM|^YSPZ|^JZPZ|^BOOK" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read tb ; do
            db2 " export to $backdir/$tb.ixf of ixf select * from $tb " >/dev/null 2>&1;
            if [ $? != 0 ]; then
                echo " $tb backup failed";
                exit -1 ;
            fi
        done;
        echo "dict backup succeed";
    );
    return $? ;
}

# 备份所有的 MQT 物化查询表
function backup_sum {
    db2 -x list tables for schema $DB_SCHEMA | egrep "^SUM" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read tb ; do
            db2 " export to $backdir/$tb.ixf of ixf select * from $tb " >/dev/null 2>&1;
            if [ $? != 0 ]; then
                echo " $tb backup failed";
                exit -1 ;
            fi
        done;
        echo "MQT backup succeed";
    ); 
    return $? ;
}

# 备份所有的sequences
function backup_seq {
    # define an variable, then uppcase variable's value
    declare -u up_schema;
    up_schema="$DB_SCHEMA";

    db2 -x "select seqname, seqtype from syscat.sequences where seqschema='$up_schema' and seqtype='S'" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read seq; do
            touch $backdir/$seq ;
            val=$(db2 -x "select nextval for $seq from sysibm.sysdummy1");
            echo "$seq $val" > $backdir/$seq;
            if [ $? != 0 ]; then
                echo "$seq backup failed";
                exit -1;
            fi
        done;
        echo "sequences backup succeed";
     );
     return $?;
}


function backup_all {
      # 连接数据库
      db2 connect to $DB_NAME user $DB_USER using $DB_PASS > /dev/null 2>&1;
      if [ $? != 0 ]; then
        echo "connect to database failed";
        return 1;
      fi
      db2 set current schema $DB_SCHEMA > /dev/null 2>&1;
      
      # backup 科目表
      echo "begin backup book tables...";
      backup_book ;
      if [ $? != 0 ]; then
        echo "backup book tables failed";
        return 1;
      fi

      # backup 原始凭证
      echo "begin backup yspz tables...";
      backup_yspz ;
      if [ $? != 0 ]; then
        echo "backup yspz tables failed";
        return 1;
      fi
       
      # backup 所有的字典表
      echo "begin backup dict tables...";
      backup_dict ;
      if [ $? != 0 ]; then
        echo "backup dict tables failed";
        return 1;
      fi

      # backup MQT 表
      echo "begin backup MQT tables...";
      backup_sum ;
      if [ $? != 0 ]; then
        echo "backup MQT tables failed";
        return 1;
      fi
      
      # backup sequences
      echo "begin backup sequences...";
      backup_seq ;
      if [ $? != 0 ]; then
        echo "backup sequences failed";
        return 1;
      fi

      return 0;
}

#########################################################
# restore database data 
#########################################################

# 恢复所有的表
# 在恢复所有的表之前，先把表之间的物化关系解除掉，然后才能导入数据
# 导入数据后，在把表的物化关系建立起来
# A -- alias
# B -- Trigger
# I -- index
# T -- 表
# V -- 视图
# S -- 物化查询表
function restore_table {
    # 删除mqt关联
    dbm.pl -t del_mqt;
    if [ $? != 0 ]; then
      echo "delete MQT failed";
      return $?;
    fi
    echo "delete MQT succeed";

    db2 -x list tables for schema $DB_SCHEMA | egrep  "\sT|S\s" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read tb ; do
            if [ ! -f $backdir/$tb.ixf ]; then
                      continue;
            fi;
            db2 " import from $backdir/$tb.ixf of ixf lobs from $backdir replace into $tb " >/dev/null 2>&1;
            if [ $? != 0 ]; then
                echo " $tb restore failed";
                exit -1 ;
            fi
        done;
        echo "book restore succeed";
    );

    # 重新关联mqt
    dbm.pl -t add_mqt;
    if [ $? != 0 ]; then
        echo "add MQT failed";
        return $?;
    fi
    echo "add MQT succeed";

    return $? ;
}

# 恢复所有的sequence
function restore_seq {
    # define an variable, then uppcase variable's value
    declare -u up_schema;
    up_schema="$DB_SCHEMA";

    db2 -x "select seqname, seqtype from syscat.sequences where seqschema='$up_schema' and seqtype='S'" | awk '{ print $1 }' |
    (
        db2 connect to $DB_NAME user $DB_USER using $DB_PASS  >/dev/null 2>&1 ;
        db2 set current schema $DB_SCHEMA >/dev/null 2>&1 ;
        while read seq; do
            seq_name=`cat $backdir/$seq | awk '{ print $1 }'` ;
            seq_val=`cat $backdir/$seq | awk '{ print $2 }'` ;
            db2 "alter sequence $seq_name restart with $seq_val" > /dev/null 2>&1; 
            if [ $? != 0 ]; then
                echo "restore $seq failed";
                exit -1;
            fi
            done;
            echo "sequences restore succeed";
     )
     return $?;
}


function restore_all {
      # 连接数据库
      db2 connect to $DB_NAME user $DB_USER using $DB_PASS > /dev/null 2>&1;
      if [ $? != 0 ]; then
        echo "connect to database failed";
        return 1;
      fi
      db2 set current schema $DB_SCHEMA > /dev/null 2>&1;
      
      # restore 科目表
      echo "begin restore book tables...";
      restore_table ;
      if [ $? != 0 ]; then
        echo "restore book tables failed";
        return 1;
      fi

      # restore sequences
      echo "begin restore sequences...";
      restore_seq ;
      if [ $? != 0 ]; then
        echo "restore sequences failed";
        return 1;
      fi

      return 0;
}

if [[ "a$1" == "aexport" ]]; then
  stopall;
  backup_all;
  if [ $? != 0 ]; then
    echo "backup failed";
    exit -1;
  fi
  echo "backup succeeded";
  runall;
  exit 0;
elif [[ "a$1" == "aimport" ]]; then
  stopall;
  restore_all;
  if [ $? != 0 ]; then
    echo "restore failed";
    exit -1;
  fi
  runall;
  echo "restore succeeded";
  exit 0;
else
    echo "usage: $0 [export|import]";
    exit 1;
fi
