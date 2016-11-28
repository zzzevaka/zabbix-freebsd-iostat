#!/bin/sh
# Description: Script for disk monitoring
# Author: Epikhin Mikhail michael@nomanlab.org
# Revision 1: Lesovsky A.V. lesovsky@gmail.com
# Revision 2 (For FreeBSD): Kuznetsov E.G. evgen_kuznetsov@yahoo.com
NUMBER=0
FROMFILE=$1
DISK=$2
METRIC=$3
if [ $# -lt 3 ]; then
        echo "FATAL: some parameters not specified"
        exit 1
fi
if [ ! -f "$FROMFILE" ]; then
        echo "FATAL: datafile not found"
        exit 1
fi

# device     r/s   w/s    kr/s    kw/s qlen svc_t  %b  
case "$3" in
"r/s")
NUMBER=2
;;
"w/s")
NUMBER=3
;;
"kr/s")
NUMBER=4
;;
"kw/s")
NUMBER=5
;;
"qlen")
NUMBER=6
;;
"svc_t")
NUMBER=7
;;
"%b")
NUMBER=8
;;
*) echo ZBX_NOTSUPPORTED; exit 1 ;;
esac
grep -w ${DISK} ${FROMFILE} | tr -s ' ' |awk -v N=${NUMBER} 'BEGIN {sum=0.0;count=0;} {sum=sum+$N;count=count+1;} END {printf("%.2f\n", sum/count);}'

