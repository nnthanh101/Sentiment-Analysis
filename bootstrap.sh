#!/bin/bash
set -e

. .env.sh
# eval $(cat .env | sed 's/^/export /')

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


echo "#########################################################"
echo "Running deploy.sh ..."
echo "#########################################################"
echo

docker run -it --rm \
       -v "$HOME/.aws:/root/.aws" \
       -v $PWD:/project \
       docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'

# docker run -it --rm \
#        -v ${PWD}:/project \
#        docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'

# docker run -it --rm \
#        -e ${AWS_ACCESS_KEY_ID} \
#        -e ${AWS_SECRET_ACCESS_KEY} \
#        -e ${AWS_DEFAULT_REGION} \
#        -v ${PWD}:/project docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'

## TODO: if using AWS SSO
# docker run -it --rm \
#        -e ${AWS_ACCESS_KEY_ID} \
#        -e ${AWS_SECRET_ACCESS_KEY} \
#        -e ${AWS_DEFAULT_REGION} \
#        -e ${AWS_SESSION_TOKEN} \
#        -v ${PWD}:/project docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'       
