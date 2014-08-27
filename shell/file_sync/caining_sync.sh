#!/bin/bash


# 参数错误提示 
function usage {
    echo "使用方法： 
sync.sh -r 'no'                             (是否是同步远端服务器. 'ssh -p 62222'：同步远端; 'no'：同步本地.  默认: 'no')
        -s '/home/caining/tmp/demo/perl'    (要监控并同步的源路径.                                                      )
        -t '/home/caining/tmp/demo/t'       (要同步到的目标路径.                                                        )
";
    exit 0;
}

### 主逻辑

# 源目录
src='';
# 目标目录
target='';
# 是否要同步远端的文件
remote='no';
while getopts "s:t:r:" arg 
do
    case $arg in
        s)
            src=$OPTARG;
            ;;
        r)
            remote=$OPTARG;
            ;;
        t)
            target=$OPTARG;
            ;;
        ?)
            usage;
            return 1;
            ;;
    esac
done

# 是否远程同步 不能为空
if [ "x$remote" == "x" ]; then
    usage;
    return 1;
fi

# 源目录 不能为空
if [ "x$src" == "x" ]; then
    usage;
    return 1;
fi

# 目标目录 不能为空
if [ "x$target" == "x" ]; then
    usage;
    return 1;
fi

inotifywait -mrq --timefmt '%m/%d/%y %H:%M' --format '%T %w%f%e' -e modify,delete,create,attrib $src | 
(
    while read files; do
        r=`ps -ef | grep 'rsync -avztopgl --delete' | grep -v 'grep' | awk '{ print  $2 }'`;
        if [ "x$r" == "x" ]; then
            echo "########## sync";
            if [ "$remote" == "no" ]; then
                # 本地同步
                rsync -avztopgl --delete $src  $target;
            else
                # 远程同步
                rsync -avztopgl --delete -e "$remote" $src $target;
            fi
        else
            echo "######### already run sync";
        fi
    done
);

# 要监控的源目录
# 将perl目录里面的内容进行同步到目标目录中
#src='/home/caining/tmp/demo/perl/';
# 将perl目录整个同步到目标目录中
#src='/home/caining/tmp/demo/perl';
#target='caining@127.0.0.1:/home/caining/tmp/demo/t';


