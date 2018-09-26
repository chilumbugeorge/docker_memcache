#!/bin/bash

declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
    cont_status=$(docker ps -a |grep $key);
    if [[ "$cont_status" != "" ]]; then
        echo -e " container $key ${GREEN}already exists${NC}"
    else
        cont_create=$(docker run -td -i -d -v /srv/${key//[[:blank:]]/}:/opt/memcache -v /proc:/writable-proc --sysctl net.core.somaxconn=4096 --hostname $key --name $key memcached:1.4.25 bash);
        ip_bind=$(pipework em1 $key ${value//[[:blank:]]/}/24@10.1.24.254);
        echo $key "Container created:" $cont_create
        echo $key "bound to" ${value//[[:blank:]]/}/24@10.1.24.254
    fi
done < "/opt/docker_memcache/scripts/memcache_system_upgrade/containers.txt"
exit
