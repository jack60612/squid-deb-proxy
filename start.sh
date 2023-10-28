#!/bin/bash

CONFIG=/etc/squid-deb-proxy/squid-deb-proxy.conf
CACHE_DIR=/var/cache/squid-deb-proxy
SQUID_ARGS="-YC -f $CONFIG"

if [ "$ENABLE_AVAHI" ]; then 
    # Advertise the availability of the cache by starting avahi-daemon
    avahi-daemon -D
fi
# load common functions
# shellcheck source=/dev/null
source /usr/share/squid-deb-proxy/init-common.sh
# start squid (modified from init file for squid-deb-proxy)
start () {
        pre_start

        umask 027
        ulimit -n 65535
        cd "$CACHE_DIR" || exit
        # shellcheck disable=SC2086
        /usr/sbin/squid $SQUID_ARGS
}
start 
