#!/usr/bin/env ksh

#
# Let-Me-In (client)
#
# for OpenBSD
# by ste.vaidis@gmail.com
#

TITLE="OpenBSD Firewall"
USER=$(whoami)
IP=$(w | grep $USER | awk {'print $3'})

echo "$USER $IP" | nc -w1 localhost 3000 &

(
    items=15
    processed=0
    while [ $processed -le $items ]; do
        pct=$(( $processed * 100 / $items ))
        echo "XXX\n"
        echo "\nHello $USER from $IP"
        echo "\nYou have 15 seconds to connect ($processed)"
        echo "XXX"
        echo "$pct"
        processed=$((processed+1))
        sleep 1
    done
) | dialog --title "$TITLE" --gauge "\nWait please..." 10 50 0