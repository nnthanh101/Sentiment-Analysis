FROM alpine:3.11
LABEL maintainer="Thanh Nguyen<nnthanh101@gmail.com>"

ARG HELM_VERSION=3.1.2
ARG KUBECTL_VERSION=1.17.2
ARG AWS_IAM_AUTH_VERSION=0.5.0


RUN apk -v add --update --no-cache curl zip sed wget jq gettext

## Install python3 & awscli
RUN apk add --update --no-cache python3 && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    pip3 install awscli && \
    rm -rf linux-amd64 && \
    rm -f /var/cache/apk/*

## Install aws-iam-authenticator (latest version)
RUN curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator && \
    mv aws-iam-authenticator /usr/bin/aws-iam-authenticator && \
    chmod +x /usr/bin/aws-iam-authenticator

## Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip && \
    unzip ./terraform_0.11.14_linux_amd64.zip -d /usr/local/bin/

## Install kubectl (same version of aws esk)
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

## Install helm, helm-diff plugins, docker
# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
RUN apk add --update --no-cache curl ca-certificates bash git less openssh docker-cli && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    helm plugin install https://github.com/databus23/helm-diff --version master

## Install Helmsman
RUN curl -L https://github.com/Praqma/helmsman/releases/download/v3.1.0/helmsman_3.1.0_linux_amd64.tar.gz | tar zx && \
    chmod +x helmsman && \
    mv ./helmsman /usr/local/bin/helmsman

## Install Packer
RUN curl -LO https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip && \
    unzip packer_1.5.4_linux_amd64.zip && \
    chmod +x packer && \
    mv ./packer /usr/local/bin/packer

## Installing node, npm, yarn, serverless.com framework 
RUN apk add --update --no-cache nodejs nodejs-npm yarn && \
    npm install -g serverless

## Installing CDK
RUN npm install -g aws-cdk

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
# ENTRYPOINT ["aws"]