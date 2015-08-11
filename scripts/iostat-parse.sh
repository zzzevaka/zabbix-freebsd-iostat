#!/usr/bin/env bash
# script for FreeBSD iostat monitoring
# parse iostat info

NUMBER=0
FROMFILE=$1
DISK=$2
METRIC=$3
ALLTIME='grep -v total'

[[ $# -lt 3 ]] && { echo "FATAL: some parameters not specified"; exit 1; }
[[ -f "$FROMFILE" ]] || { echo "FATAL: datafile not found"; exit 1; }

if [ "$4" == "alltime" ]
then
    ALLTIME='grep total'	
fi

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
"wait")
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

grep -w $DISK $FROMFILE | $ALLTIME | tr -s ' ' | awk -v N=$NUMBER '{print $N}'

