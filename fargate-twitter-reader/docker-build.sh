#!/bin/bash
set -e

. ../.env.sh

export DOCKERHUB_REPOSITORY=fargate-twitter-reader

started_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Docker build & push >> starting at ${started_time}"
echo "#########################################################"
echo
docker login --username ${DOCKER_REGISTRY_USERNAME} --password ${DOCKER_REGISTRY_PASSWORD} 
docker build -t ${DOCKERHUB_REPOSITORY} .
docker tag ${DOCKERHUB_REPOSITORY} ${DOCKER_REGISTRY_NAMESPACE}/${DOCKERHUB_REPOSITORY}
docker push ${DOCKER_REGISTRY_NAMESPACE}/${DOCKERHUB_REPOSITORY}
ended_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Docker build & push >> finished at ${ended_time}"
echo "#########################################################"
echo
