#!/bin/bash
nc -z 127.0.0.1 11211
echo `date`
stat=$(echo "stats" | nc  localhost 11211 > /dev/null 2>&1  && echo "ok" || echo "fail")
if [[ "$stat" != *"ok"* ]]; then
    echo "memcached has been stopped and not running"
    exit 2
else
    echo "memcached is active and running"
    exit 0
fi
