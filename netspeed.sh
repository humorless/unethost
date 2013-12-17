#!/bin/bash

if [ -z "$1" ]; then
        echo
        echo usage: $0 network-interface
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

IF=$1

while true
do
        R1=`cat /sys/class/net/$1/statistics/rx_bytes`
        T1=`cat /sys/class/net/$1/statistics/tx_bytes`
        sleep 1
        R2=`cat /sys/class/net/$1/statistics/rx_bytes`
        T2=`cat /sys/class/net/$1/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TbPS=`expr $TBPS \* 8`
        RbPS=`expr $RBPS \* 8`
        TMBPS=`expr $TbPS / 1048576`
        RMBPS=`expr $RbPS / 1048576`
        echo "tx $1: $TMBPS Mb/s rx $1: $RMBPS Mb/s"
done
