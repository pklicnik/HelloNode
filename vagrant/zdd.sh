#!/bin/bash

OLD_CONTAINER_ID=`docker ps | grep pklicnik/hello-node | awk '{print $1}'`
OLD_IMAGE_ID=`docker images | grep pklicnik/hello-node | awk '{print $3}'`

cd /opt/vagrant
CONTAINER_NAME=pklicnik/hello-node:`date +%m%d_%H%M%S`
docker build --no-cache=true -t $CONTAINER_NAME .
docker run -itPd $CONTAINER_NAME
CONTAINER_ID=`docker ps | grep "$CONTAINER_NAME" | awk '{print $1}'`
CONTAINER_PORT=`docker inspect $CONTAINER_ID | grep HostPort | cut -d '"' -f 4 | head -1`
sed -e "s@<target>@http\:\/\/127\.0\.0\.1\:${CONTAINER_PORT}@g" /opt/vagrant/nginx-template > /etc/nginx/sites-enabled/hellonode
service nginx reload

docker stop $OLD_CONTAINER_ID
docker rmi -f $OLD_IMAGE_ID
