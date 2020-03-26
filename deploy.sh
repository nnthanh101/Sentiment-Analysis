#!/bin/bash
set -e

. .env.sh
# eval $(cat .env | sed 's/^/export /')

started_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Deployment >> Stating at ${started_time}"
echo "#########################################################"
echo

echo
echo "#########################################################"
echo "Environment Setup"
echo "#########################################################"
echo

python3 --version
aws --version
# aws-iam-authenticator help
# terraform -version
# ## TODO
# # kubectl version
# # helm list
# # helmsman --v
# # packer -machine-readable version
# echo "NodeJS Environment"
node -v
# npm -v
# yarn -version
# serverless -version

echo
echo "#########################################################"
echo "Deployment ..."
echo "#########################################################"
echo

ended_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Deployment >> finished at ${ended_time}"
echo "#########################################################"
echo