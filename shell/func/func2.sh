#!/bin/bash

declare test="hello";

function hello {
    #echo "hello world";
    if [ $test == "hello" ]; then
        #exit -1;
        echo "hello world";
    fi
    return $?
}

baby () {
    echo "welcome baby";   
}

hello;
if [ $? -eq 0 ]; then
    echo $?;
fi
baby ;
