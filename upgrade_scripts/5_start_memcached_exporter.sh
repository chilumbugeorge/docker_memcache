#!/bin/bash
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

declare -A containers

printf "\n"
echo -e "${GREEN}*********************************************************************************************************************"
echo -e "${NC}Please!!!, ${RED}MANUALLY hit CTL C ${NC}and run this same script ${GREEN}(8_start_redis_exporter.sh) ${NC} again. "
echo -e "${NC}Stop when all redis_exportes are running and canot hit contol C anymore. "
echo -e "${BLUE}******************************************************************************************************************${NC}"
printf "\n"

while IFS== read -r key value; do
    containers[$key]=${value}
    X=$(docker exec $key /opt/memcached_exporter/memcached_exporter --memcached.address="${key//[[:blank:]]/}:11211");
    printf "\n"
    echo $X;
    printf "\n"
    echo -e "${GREEN}*********************************************************************************************************************"
    echo -e "${NC}Please!!!, ${RED}MANUALLY hit CTL C ${NC}and run this same script ${GREEN}(8_start_redis_exporter.sh) ${NC} again. "
    echo -e "${NC}Stop when all redis_exportes are running and canot hit contol C anymore. "
    echo -e "${BLUE}******************************************************************************************************************${NC}"
    printf "\n"
done < "/opt/docker_memcache/files/containers.txt"
exit
