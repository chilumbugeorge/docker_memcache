#!/bin/bash
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
    S=$(docker exec -t $key sysctl net.core.somaxconn);
    M=$(docker exec -t $key service memcached start);
    MPS=$(docker exec -t $key ps -ef |grep memcached);

    echo $key ":" $MPS;
    printf "\n"
    echo -e "${BLUE}SLEEPING FOR 30 SECONDS......${NC}"
    sleep 30
done < "/opt/docker_memcache/files/containers.txt"