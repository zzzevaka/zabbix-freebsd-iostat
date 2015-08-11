#!/usr/bin/env bash
# script for FreeBSD iostat monitoring
# collecting iostat info

SECONDS=$2
TOFILE=$1
IOSTAT="/usr/sbin/iostat"

[[ $# -lt 2 ]] && { echo "FATAL: some parameters not specified"; exit 1; }

$IOSTAT -x 1 2 | awk '
    BEGIN {cnt = 0}
    {
        if ($1~/extended|device/) {
            cnt+=0.5
        }
        else if (cnt == 1) {
                printf "%s total\n", $0
        }
        else {
                print $0
        }
        }' > $TOFILE
echo 0
