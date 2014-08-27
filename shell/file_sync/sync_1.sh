#!/bin/bash

# 同步的源目录
src="/home/jackliu/下载";

# 文件同步的目标目录
des="/home/jackliu/tmp/jackliu";

inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format '%T %w%f%e' \
-e modify,delete,create,attrib \
${src} \
| while read D E F
    do
        rsync -aHvzt --delete --progress ${src} ${des} ;
        echo "${src} was rsynced" ;
        echo "----------------------------------------------------------" ;
    done
    exit 0;
