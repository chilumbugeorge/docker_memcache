# docker_memcache

Docker package for creating docker image and containers for mcrouter, a routing solution for memcached. I have created this package to simply and speed up the process of recreating docker containers during upgrades or maintenace. For instance, if you have about 6 docker hosts each with about 10-15 containers for different mcrouter for different teams/functions, trying to upgrade or performan some kind of maintence would take us about 2 days. With this package and the scripts included, the process has been cut to minutes.

## File structure

**manual.txt**: This file contains the instructions to create a memcached docker image

**Dockerfile**: is the dockerfile config to be used for creating the mcrouter image with all the necessary supporting system tools.

**upgrade_scripts**: This folder contains a sorted list of bash scripts to be used gracefully to stop services and containers, and rebuild containers once more using an upgraded docker image. These scripts help to significantly speed up the docker container recreation process following mcrouter or OS or upgrades of other services. Below are a sorted list of the scripts, and should always be run in order from 0 step-by-step.

```
total 24
-rwxr-xr-x 1 root root  516 Jun 28 14:53 0_stop_all_services.sh
-rwxr-xr-x 1 root root  850 Jun 28 14:54 1_remove_containers.sh
-rwxr-xr-x 1 root root  374 Jun 28 14:56 2_create_containers.sh
-rwxr-xr-x 1 root root  287 Jun 29 17:30 3_bind_IP.sh
-rwxr-xr-x 1 root root  504 Jun 28 14:57 4_start_services.sh
-rwxr-xr-x 1 root root 1441 Jun 28 14:58 5_start_memcached_exporter.sh
```

**mcrouter**: This folder contains mcrouter config files with memcached server configurations. So update the names of these config files appropriately and also change the IPs of the memcached appropriately.

**consul**: This folder contains consulconfig files. No need to do anythihg as the scripts in the upgrade_scripts folder handle pretty much everything.

**files**: The files folder contains a file with the container host names and their IPs used by the scripts in the upgrade_scripts folder. Update the hostname and their mapped IPs appropriately to reflect the names of your mcrouter containers.

## Create mcrouter docker image
1. To create an memcached docker image, open the "manual" file and follow the insructions there on how to create a docker image.
2. 

