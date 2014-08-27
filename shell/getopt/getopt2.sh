#!/bin/bash

#
# ./getopt.sh -c config a b -u -d "this is desc" --work-dir "/" --verbose
#

# function Usage
function Usage {
    echo "Usage:" 1>&2
    echo " $0 [Option]" 1>&2
    echo "Option:" 1>&2
    echo " --help               Display this message and exit." 1>&2
    echo " -t, --type [F]       Set configure file." 1>&2
    echo "Example:"
    #echo "./getopt.sh --config-file /etc/passwd a b --unk --desc-str 'this is a desc str' --work-dir . --verbose";
    echo "./getopt.sh -t backup|--type backup";
    exit 1
}

function hello {
    echo "hello world";
}
                                                         
# parse argument
# $0 ./getopt.sh 即命令本身
# $1 --config-file 第一个参数
# $2 /etc/passwd 第二个参数
# $# 参数的个数，不包括命令本身，上例中$#为9
# $@ 参数本身的列表，不包括命令本身，上例中 $@为 --config-file /etc/passwd a b --unk --desc-str 'this is a desc str' --work-dir . --verbose``
# $* 和$@相同，但"$@"和"$*"（加引号）并不同，"$*"将所有的命令参数解释成一个字符串，"$@"是一个参数数组

# eval set 会重新排列参数的顺序，也就是改变$1,$2...$n的值，
eval set -- "$(getopt -n $0 -o "t:" -l "help,type:" "--" "$@")"
#选项后面的冒号表示该选项需要参数

if [ $? -ne 0 ]
    then
       Usage
fi
#echo "argv now [$@] [$*]";
#echo "begin parse argument........";
for arg
do
#    echo "encounter [$arg]";
    case "$arg" in
        --help)            Usage; shift; break;;
#        --verbose)         verbose=1; shift;;
#        --work-dir)        shift; work_dir="$1"; shift;;
#        -c|--config-file)  shift; config_file="$1"; shift;;
#        -u|--unk)          unk=1; shift;;
#        -d|--desc-str)     shift; desc_str="$1"; shift;;
         -t|--type)        shift; t="$1"; shift; break;;
        --)                shift; Usage; break;;
    esac
    shift ;
done
                                                                                                                       
# rest paremeters
#if [ $# -lt 2 ]
#   then
#      Usage;
#fi
#input_file="$1"
#output_file="$2"
echo "get the following argument:";
echo "----------------------------------------";
#echo "verbose => $verbose";
#echo "unk => $unk";
#echo "d|desc-str => $desc_str";
#echo "c|config-file => $config_file";
#echo "verbose => $verbose";
#echo "work-dir => $work_dir";
#echo "input => $input_file";
#echo "output => $output_file";
echo "t|type => $t";

if [ $t = "backup" ]; then
    hello ;
elif [ $t = "restore" ]; then
    echo "restore";
fi

