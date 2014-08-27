#!/bin/bash

<<comment
参数:
    -d zdb   数据库
    -s fhyd  schema
comment


function usage {
    echo "使用方法：
drop_schema.sh -d zdb (要操作的数据库)
               -s fhyd (要操作的schema)";
    exit 0;
}

# connect to db 
function connect_db {
    echo "开始连接数据库......";
    db2 connect to zdb_dev user db2inst using db2inst ;
    db2 set current schema fhyd ;
    echo "数据库连接成功......";
}

function drop_tables {
    for file in `db2 -x list tables`
    do 
        db2 "drop table $file" ;
    done 
}

while getopts "d:s:" arg
do
    case $arg in 
        d)
            db=$OPTARG;
            ;;
        s)
            schema=$OPTARG;
            ;;
        ?)
            usage;
            return 1;
            ;;
    esac
done

if [ "z$db" == "z" ]; then
    usage;
    return 1;
fi

if [ "z$schema" == "z" ]; then
    usage;
    return 1;
fi
