#!/bin/bash

config_sh=/tmp/config-log.sh
tar_cmd="tar xf $1 -C logging-config --strip-components=1"

docker cp $1 DOCKER_NAME:$1
echo -e "rm -rf logging-config\nmkdir logging-config\n$tar_cmd\ncd logging-config && source ./cli.sh" > $config_sh 
docker cp $config_sh DOCKER_NAME:$config_sh
docker exec -it DOCKER_NAME sh $config_sh
