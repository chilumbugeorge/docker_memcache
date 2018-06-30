#!/bin/bash
nc -z 127.0.0.1 11211
echo `date`
stat=$(service memcached status | grep "running");
if [[ "$stat" != *"* memcached is running"* ]]; then
    echo "memcached has been stopped and not running"
    exit 2
else
    echo "memcached is active and running"
    exit 0
fi
