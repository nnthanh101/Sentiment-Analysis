# export AWS_ACCOUNT_ID=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .accountId)
# export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
export AWS_ACCESS_KEY_ID=<aws-access-key-id>
export AWS_SECRET_ACCESS_KEY=<aws-secret-access-key>
export AWS_DEFAULT_REGION=ap-southeast-1

export DOCKER_REGISTRY_USERNAME=<your-docker-registry-username>
export DOCKER_REGISTRY_NAMESPACE=<your-docker-registry-namespace>
export DOCKER_REGISTRY_PASSWORD=<your-docker-registry-password>
export DOCKER_REGISTRY_EMAIL=<your-docker-registry-email>