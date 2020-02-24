#!/bin/sh

export JAVA_HOME=$1
export PATH=$PATH:$2
export JBOSS_MODULEPATH=$3

if [ "x$8" = "x" ]; then
    $4 -c $5 -b $6 >$7 2>&1
else
    $4 --host-config=$8 -c $5 -b $6 >$7 2>&1
fi
