#!/bin/sh
# Description: Script for iostat monitoring
# Author: Epikhin Mikhail michael@nomanlab.org
# Revision 1: Lesovsky A.V. lesovsky@gmail.com
# Revision 2 (For FreeBSD): Kuznetsov E.G. evgen_kuznetsov@yahoo.com
SECONDS=$2
TOFILE=$1
IOSTAT="/usr/sbin/iostat"
if [ $# -lt 2 ]; then
    echo "FATAL: some parameters not specified"
    exit 1
fi

(DISK=$(${IOSTAT} -x -w 1 -t da -c ${SECONDS} | awk 'BEGIN {check=0;block=0;} {if(check==1 && $1=="extended"){check=0}if(check==1 && $1!="" && block>1){print $0}if($1=="device"){check=1;block=block+1;}}' | tr '\n' '|'); echo ${DISK} | tr '|' '\n' > ${TOFILE})&

echo 0

