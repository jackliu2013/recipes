#!/bin/bash
# 数据库管理
###### 必须在数据库服务器实例才能执行 ########
#################################
######### 还存在的问题 ##########
#################################
# 此备份程序只针对已存在的数据库而言
# 1. 对于已经存在的数据库，是否会将 数据库目录 与 自动存储目录 修改为备份介质的 数据库目录 与 自动存储目录
# 2. 如果表空间容器变化了，要进行重定向恢复
# 3. 恢复到其他名字的数据库是否可以 
# 4. 对于compress压缩备份而言，64位机与32位机的备份介质之间不能够相互恢复

# 备份函数
function backup {
    db='zdb';           # 要备份的数据库
    path='/db2back';    # 备份文件的目录
    baktype='inc';      # 备份方式： 'all' 是全备；'inc' 增量备份
    while getopts "d:p:t:" arg 
    do
        case $arg in
            d)
                db=$OPTARG;
                ;;
            p)
                path=$OPTARG;
                ;;
            t)
                baktype=$OPTARG;
                ;;
            ?)
                usage;
                return 1;
                ;;
        esac
    done
    # 数据库名不能为空
    if [ "x$db" == "x" ]; then
        usage;
        return 1;
    fi
    # 备份路径名不能为空
    if [ "x$path" == "x" ]; then
        usage;
        return 1;
    fi
    # 备份方式不能为空
    if [ "x$baktype" == "x" ]; then
        usage;
        return 1;
    # 备份方式只能是 'all' 或 'inc'
    elif [[ "x$baktype" != "xall" && "x$baktype" != "xinc" ]]; then
        usage;
        return 1;
    fi

    echo "
**********************************
*** 数据库名： $db
*** 备份路径： $path
*** 备份类型： $baktype
**********************************
";
    echo "**** 备份数据库[$db] ...";
    # 执行备份逻辑
    _backup $db $path $baktype;
    if [ "x$?" != "x0" ]; then
        echo "**** 备份数据库[$db]失败";
        return 1;
    fi
    echo "**** 备份数据库[$db]成功";
    return 0;
}

# 备份的实现
function _backup {
    db=$1;
    path=$2;
    baktype=$3;
    
    # 数据库名称转大写
    udb="";
    declare -u udb;
    udb=$db;
    if [ "x$baktype" == "xall" ]; then
        echo "#############################";
        echo "# 1. 执行全备份";
        db2 backup db $db to $path compress;
        sta=$?;
        if [ "x$sta" != "x0" ]; then
            if [ "x$sta" == "x4" ]; then
                # 可以通过以下的命令查到Appl Handle, 通过命令 db2 force application "(Appl Handle)强制结束应用，在这里我们不建议这样做，要手>动关闭某些应用程序"
                echo "以下应用正在连接此数据库, 请关闭以下应用";
                db2 "list application for db $db" | grep $udb;
            fi
            echo "# 全备份失败";
            return 1;
        fi
        echo "# 全备份成功";
    elif [ "x$baktype" == "xinc" ]; then
        echo "#############################";
        echo "# 1. 执行增量备份";
        db2 backup db $db incremental delta to $path compress;
        sta=$?;
        if [ "x$sta" != "x0" ]; then
            if [ "x$sta" == "x4" ]; then
                # 可以通过以下的命令查到Appl Handle, 通过命令 db2 force application "(Appl Handle)强制结束应用，在这里我们不建议这样做，要手>动关闭某些应用程序"
                echo "以下应用正在连接此数据库, 请关闭以下应用";
                db2 "list application for db $db" | grep $udb;
            fi
            echo "# 增量备份失败";
            return 1;
        fi
        echo "# 增量备份成功";
    fi
    return 0;
}

# 恢复函数
function restore {
    sdb='zdb';          # 数据库备份的数据库名
    path='/db2back';    # 数据库备份的路径
    version='';         # 数据库备份的时间戳版本: '20131012225521'
    tdb='zdb';          # 要恢复的 目标数据库
    redirect='no';      # 是否为重定向恢复： 'yes' 是; 'no' 否
    forward='no';       # 恢复时前滚的版本： 'no' 不前滚；'2013-10-12-21.40.25.000000' 前滚到指定的时间戳
    while getopts "s:p:v:t:r:f:" arg
    do
        case $arg in
            s)
                sdb=$OPTARG;
                ;;
            p)
                path=$OPTARG;
                ;;
            v)
                version=$OPTARG;
                ;;
            t)
                tdb=$OPTARG;
                ;;
            r)
                redirect=$OPTARG;
                ;;
            f)
                forward=$OPTARG;
                ;;
            ?)
                usage;
                return 1;
                ;;
        esac
    done
    # 数据库备份的数据库名 不能为空
    if [ "x$sdb" == "x" ]; then
        usage;
        return 1;
    fi
    # 数据库备份的路径 不能为空
    if [ "x$path" == "x" ]; then
        usage;
        return 1;
    fi
    # 数据库备份的时间戳版本 不能为空
    if [ "x$version" == "x" ]; then
        usage;
        return 1;
    fi
    # 要恢复的 目标数据库 不能为空
    if [ "x$tdb" == "x" ]; then
        usage;
        return 1;
    fi
    # 是否为重定向恢复 不能为空
    if [ "x$redirect" == "x" ]; then
        usage;
        return 1;
    fi
    # 是否为重定向恢复 必须是 'yes' 或者 'no'
    if [[ "x$redirect" != "xyes" && "x$redirect" != "xno" ]]; then
        usage;
        return 1;
    fi
    # 恢复时前滚的版本 不能为空
    if [ "x$forward" == "x" ]; then
        usage;
        return 1;
    fi
    
    echo "
**********************************
*** 备份数据库名：  $sdb
*** 备份路径：      $path
*** 备份版本：      $version
*** 目标数据库名：  $tdb
*** 是否重定向：    $redirect
*** 前滚：          $forward
**********************************
";
    echo "**** 恢复数据库[$sdb]到[$tdb] ...";
    # 执行备份逻辑
    _restore $sdb $path $version $tdb $redirect $forward;
    if [ "x$?" != "x0" ]; then
        echo "**** 恢复数据库[$sdb]到[$tdb] 失败";
        return 1;
    fi
    echo "**** 恢复数据库[$sdb]到[$tdb] 成功";
    return 0;
}

# 恢复数据库实现
function _restore {
    sdb=$1;         # 数据库备份的数据库名
    path=$2;        # 数据库备份的路径
    version=$3;     # 数据库备份的时间戳版本: '20131012225521'
    tdb=$4;         # 要恢复的 目标数据库
    redirect=$5;    # 是否为重定向恢复： 'yes' 是; 'no' 否
    forward=$6;     # 恢复时前滚的版本： 'no' 不前滚；'2013-10-12-21.40.25.000000' 前滚到指定的时间戳
    echo "#############################";
    echo "# 1. 开始版本恢复 ...";
    if [ "x$redirect" == "xyes" ]; then
        if [ "x$forward" == "xno" ]; then
            db2 restore db $sdb incremental automatic from $path taken at $version into $tdb redirect generate script redirect.ddl without rolling forward;
            sta=$?;
        else
            db2 restore db $sdb incremental automatic from $path taken at $version into $tdb redirect generate script redirect.ddl;
            sta=$?;
        fi
        if [ "x$sta" == "x0" ]; then
            echo "
在目标所在表空间容器 不存在 或 不能使用的情况下使用
已生成redirect.ddl脚本，请修改相应的表空间容器为可用的容器后执行以下命令 
db2 -tvf redirect.ddl，成功执行命令即可
";
            exit 0;
        fi
    elif [ "x$redirect" == "xno" ]; then
        if [ "x$forward" == "xno" ]; then
            db2 restore db $sdb incremental automatic from $path taken at $version into $tdb without rolling forward;
            sta=$?;
        else
            db2 restore db $sdb incremental automatic from $path taken at $version into $tdb;
            sta=$?;
        fi
    fi
    # 数据库名称转大写
    udb="";
    declare -u udb;
    udb=$tdb;
    if [ "x$sta" != "x0" ]; then
        if [ "x$sta" == "x4" ]; then
            # 可以通过以下的命令查到Appl Handle, 通过命令 db2 force application "(Appl Handle)强制结束应用，在这里我们不建议这样做，要手>动关闭某些应用程序"
            echo "以下应用正在连接此数据库, 请关闭以下应用";
            db2 "list application for db $tdb" | grep $udb;
        fi
        echo "# 版本恢复失败";
        return 1;
    fi
    echo "# 版本恢复完成";
    if [ "x$forward" == "xno" ]; then
        return 0;
    fi

    echo "#############################";
    echo "# 2. 开始前滚数据 ...";
    # 前滚到指定的时间戳
    # 1. 如果恢复到某个版本后，插入了一条数据
    # 2. 再恢复到刚刚那个版本，完后停止前滚，查询数据表，少了刚刚插入的那条数据。
    # 3. 再恢复到刚刚那个版本，前滚到日志的末尾，查询数据表，还是少了刚刚插入的那条数据
    # 总结： 如果前滚到某个时间戳停止后，那么就会生成一个新的日志链，之后的数据将永久地丢失了
    # 当指定了前滚时间戳的时候，那么恢复之后将前滚到指定的时间点
    # 在钱滚结束前，只能向后前滚，如果再向前前滚 失败
    # db2 rollforward db zdb to "2013-10-12-21.40.25.000000" using local time and stop
    # 前滚到指定的时间戳
    db2 rollforward db $tdb to "$forward" using local time and stop;
    sta=$?;
    if [ "x$sta" != "x0" ]; then
        echo "# 前滚数据失败";
        return 1;
    fi
    echo "# 前滚数据完成";

    return 0;
}
 
# 参数错误提示 
function usage {
echo "使用方法： 
dbm.sh  backup                  (*备份操作)
        -d 'zdb'                (要备份的数据库名称.                                                         默认: 'zdb')
        -p '/db2back'           (备份路径.                                                                   默认： '/db2back')
        -t 'all'                (备份方式. 'all'：全备; 'inc'：增量备份.                                     默认：'inc')

    或

dbm.sh  restore                 (*恢复操作)
        -s 'zdb'                (数据库备份的数据库名.                                                       默认：'zdb')
        -p '/db2back'           (数据库备份的路径.                                                           默认：'/db2back')
        -v '20131012225521'     (*数据库备份的时间戳版本. 格式：'20131012225521')
        -t 'zdb'                (要恢复的目标数据库.                                                         默认：'zdb')
        -r 'no'                 (是否为重定向恢复.'yes' 是; 'no' 否；                                        默认：'no')
        -f 'no'                 (恢复时前滚的版本.'no' 不前滚；'2013-10-12-21.40.25.000000' 指定的时间戳.    默认：'no')

";
    exit 0;
}


#############
# 主调度逻辑
#############
# 删除第一个参数
op="$1";
shift 1;
if [ "x$op" == "xbackup" ]; then
    backup $*;
elif [ "x$op" == "xrestore" ]; then
    restore $*;
else
    usage;
fi
