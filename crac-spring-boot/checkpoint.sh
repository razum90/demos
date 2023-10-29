#!/usr/bin/env bash
set -e

mvn clean package
docker build -t tsc/crac-spring-boot:builder .
docker run -d --privileged --rm --name=crac-spring-boot --ulimit nofile=1024 -p 8080:8080 -v $(pwd)/target:/opt/mnt -e FLAG=-r tsc/crac-spring-boot:builder
echo "Please wait during creating the checkpoint..."
sleep 10
docker commit --change='ENTRYPOINT ["/opt/app/entrypoint.sh"]' $(docker ps -qf "name=crac-spring-boot") tsc/crac-spring-boot:checkpoint
docker kill $(docker ps -qf "name=crac-spring-boot")