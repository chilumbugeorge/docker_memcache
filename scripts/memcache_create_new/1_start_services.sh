#!/bin/bash
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
     mem_status=$(docker exec -t $key ps -ef |grep memcached);
    if [[ "$mem_status" != "" ]]; then
        echo -e " memcache $key is ${GREEN}already running${NC}"
    else
        S=$(docker exec -t $key sysctl net.core.somaxconn);
        M=$(docker exec -t $key service memcached start);
        X=$(docker exec $key /opt/memcached_exporter/memcached_exporter --memcached.address="${key//[[:blank:]]/}:11211" > /dev/null 2>&1 &);
        MPS=$(docker exec -t $key ps -ef |grep memcached);
        XPS=$(docker exec -t $key ps -ef |grep memcached_exporter);

        echo $key ":" $MPS;
        echo $key ":" $XPS;
    fi
done < "/opt/docker_memcache/scripts/memcache_create_new/containers.txt"
