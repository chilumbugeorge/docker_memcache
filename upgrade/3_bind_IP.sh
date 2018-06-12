#!/bin/bash

declare -A containers

while IFS== read -r key value; do
    containers[$key]=${value}
    IP=$(sudo pipework eno1 $key ${value//[[:blank:]]/}/23@10.1.5.254);
    echo $key "bound to" ${value//[[:blank:]]/}/23@10.1.24.254
done < "/opt/Docker_memcache/upgrade/containers.txt"
exit
