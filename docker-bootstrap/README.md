# [AWS CLI](https://aws.amazon.com/cli/) in [Alpine Docker](https://hub.docker.com/_/alpine)

To avoid requiring the AWS CLI to be installed on CI/CD Laptop/Cloud9/Bastion-Host/Remote-Desktop.

## CI/CD Build

<!-- TODO Travis-CI .travis.yml --> 

## Usage

Configure:

```
export AWS_ACCESS_KEY_ID=<aws-access-key-id>
export AWS_SECRET_ACCESS_KEY=<aws-secret-access-key>
export AWS_DEFAULT_REGION="<default-aws-region>"

export DOCKER_REGISTRY_USERNAME=<your-docker-registry-username>
export DOCKER_REGISTRY_NAMESPACE=<your-docker-registry-namespace>
export DOCKER_REGISTRY_PASSWORD=<your-docker-registry-password>
export DOCKER_REGISTRY_EMAIL=<your-docker-registry-email>
```

## Deployment

```
./bootstrap.sh
# docker run -it --rm -v ${PWD}:/project docker-bootstrap bash -c 'chmod +x deploy.sh; ./deploy.sh'
```
