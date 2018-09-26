#!/bin/bash
declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
    mem_status=$(docker exec -t $key ps -ef |grep memcached);
    if [[ "$mem_status" != "" ]]; then
        stop_memcached=$(docker exec -t $key pkill memcached);
        echo $key ":" $stop_memcache "memcached stopped."
    else
        echo "Container $key does not seem to have mcrouter running"
    fi
    printf "\n"
done < "/opt/docker_memcache/scripts/memcache_system_upgrade/containers.txt"
exit
