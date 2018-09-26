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
        MPS=$(docker exec -t $key ps -ef |grep memcached);
        X=$(docker exec $key /opt/memcached_exporter/memcached_exporter --memcached.address="${key//[[:blank:]]/}:11211" > /dev/null 2>&1 &);

        echo $key ":" $MPS;
        echo $X;
        printf "\n"
        echo -e "${BLUE}SLEEPING FOR 30 SECONDS......${NC}"
        sleep 30
    fi
done < "/opt/docker_memcache/scripts/memcache_system_upgrade/containers.txt"
