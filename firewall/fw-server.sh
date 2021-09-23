#!/usr/bin/env ksh

#
# Port Opener (server)
#
# for OpenBSD
# by ste.vaidis@gmail.com
#

/usr/local/bin/ncat -lk localhost 3000 | (
    while read c; do
        USER=$(echo $c  | awk {'print $1'})
        IP=$(echo $c  | awk {'print $2'})
        ps x | grep fw-allow.sh | grep $USER | grep -v grep
        if [ $? -eq 1 ]; then
                /firewall/fw-allow.sh $USER $IP
        fi
    done
)
