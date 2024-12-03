#!/bin/sh

if [ -f  "./bin/test" ];then
    cd ./bin
    startt=`date  +%s`
    i=0
    while [ $i -lt 100 ]
    do
        ./test
        let i++
    done
    endt=`date  +%s`
    tm=`expr $endt - $startt `
    echo "exec time : $tm s"
else
    echo "check the exe is existed "
fi