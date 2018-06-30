#!/bin/bash

declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
    C=$(docker run -td -i -d -v /srv/${key//[[:blank:]]/}:/opt/memcache -v /proc:/writable-proc --sysctl net.core.somaxconn=4096 --hostname $key --name $key memcached:1.4.25 bash)
    echo $key "Container created:" $C
done < "/opt/docker_memcache/files/containers.txt"
exit