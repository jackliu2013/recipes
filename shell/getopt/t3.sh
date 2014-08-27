#!/bin/bash

function Usage {
    echo "Usage ./t3.sh -m 'hello world'"; 
    exit 1;
}

function help {
    echo "need help"
}

function mess {
    local mess=$1
    echo "$mess"
}

#ARGV=`$(getopt -o "hm:" –l "help,mess:" "--" "$@")`
#eval set -- "$ARGV"
eval set -- "$(getopt -n $0 -o "hm:" -l "help,mess:" "--" "$@")"

#if [ $? -ne 0 ]
#    then
#        Usage ;
#fi

while true
do
    case "$1" in
        -h|--help)
            help ;
            shift;
            break ;;
        -m|--mess)
            mess "$2" ;
            shift;
            break;;
        *)  Usage;break;;
    esac
    shift
done

