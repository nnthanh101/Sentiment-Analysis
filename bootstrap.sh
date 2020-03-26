#!/bin/bash
set -e

eval $(cat .env | sed 's/^/export /')

started_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Docker build & push >> starting at ${started_time}"
echo "#########################################################"
echo
docker login --username ${DOCKER_REGISTRY_USERNAME} --password ${DOCKER_REGISTRY_PASSWORD} 
docker build -t docker-bootstrap docker-bootstrap
docker tag docker-bootstrap ${DOCKER_REGISTRY_NAMESPACE}/docker-bootstrap
docker push ${DOCKER_REGISTRY_NAMESPACE}/docker-bootstrap
ended_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Docker build & push >> finished at ${ended_time}"
echo "#########################################################"
echo

docker run -it --rm -v ${PWD}:/project docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'