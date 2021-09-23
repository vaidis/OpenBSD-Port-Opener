#!/usr/bin/env ksh

#
# Port Opener (server helper)
#
# for OpenBSD
# by ste.vaidis@gmail.com
#

if [ $# -ne 2 ]; then 
    logger -t "FORWARD" "fw-allow.sh executed without proper arguments: user:$1 ip:$2"
    exit
fi

USER=$1
IP=$2

logger -t "FORWARD" "Open for user $USER from $IP"

cat /firewall/user/$USER | sed "s/IP/$IP/g" > /firewall/user/$USER.tmp
echo "include '/firewall/user/$USER.tmp'" >> /etc/pf.conf
if [[ $? != 0 ]]; then echo "Fail"; fi

pfctl -f /etc/pf.conf
if [[ $? != 0 ]]; then echo "Fail"; fi

sleep 15
if [[ $? != 0 ]]; then echo "Fail"; fi

sed -i "/$USER/d" /etc/pf.conf
if [[ $? != 0 ]]; then echo "Fail"; fi

pfctl -f /etc/pf.conf
if [[ $? != 0 ]]; then echo "Fail"; fi

logger -t "FORWARD" "Close for user $USER from $IP"

rm /firewall/user/$USER.tmp

exit
