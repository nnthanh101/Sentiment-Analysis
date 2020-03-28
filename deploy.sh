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
pip3 --version
aws --version
cdk --version
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

cd cdk-python/ServerlessWidgetService
pip install -r requirements.txt
. ../../.env.sh 
echo ${AWS_PROFILE}
echo ${AWS_ACCESS_KEY_ID}
cdk deploy

echo
echo "#########################################################"
echo "AWS Bootstrapping User-Data"
echo "#########################################################"
echo

aws configure

# echo "Step 1: IAM Roles ..."
# aws iam get-role --role-name "AWSServiceRoleForElasticLoadBalancing" || aws iam create-service-linked-role --aws-service-name "elasticloadbalancing.amazonaws.com"
# aws iam get-role --role-name "AWSServiceRoleForECS" || aws iam create-service-linked-role --aws-service-name "ecs.amazonaws.com"
# aws sts get-caller-identity

# echo "Step 2: CloudFormation IaC ..."
# aws cloudformation deploy --stack-name ecs-fargate --template-file cluster-fargate-private-vpc.yml --capabilities CAPABILITY_IAM
# aws cloudformation deploy --stack-name ecs-fargate-alb --template-file alb-external.yml

# echo "Step 3: AWS VPC & ECS Fargate ..."
# export CLUSTER_NAME=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`ClusterName`].OutputValue' --output text)
# export vpc=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`VpcId`].OutputValue' --output text)
# export ecsTaskExecutionRole=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`ECSTaskExecutionRole`].OutputValue' --output text)
# export subnet_1=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`PrivateServicesSubnetOne`].OutputValue' --output text)
# export subnet_2=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`PrivateServicesSubnetTwo`].OutputValue' --output text)
# export security_group=$(aws cloudformation describe-stacks --stack-name ecs-fargate --query 'Stacks[0].Outputs[?OutputKey==`ContainerSecurityGroup`].OutputValue' --output text)
# echo $CLUSTER_NAME + $vpc + $ecsTaskExecutionRole + $subnet_1 + $subnet_2 + $security_group

# ecs-cli configure --region $AWS_REGION --cluster $CLUSTER_NAME --default-launch-type FARGATE --config-name $ECS_CLUSTER_CONFIG
# aws ec2 authorize-security-group-ingress --group-id "$security_group" --protocol tcp --port 3000 --cidr 0.0.0.0/0

# echo "Step 4: Deploy fargate_twitter_reader NodeJS Backend: port 3000:3000"
# export SERVICE_NAME=fargate_twitter_reader
# export target_group_arn=$(aws cloudformation describe-stack-resources --stack-name ecs-fargate-alb | jq -r '.[][] | select(.ResourceType=="AWS::ElasticLoadBalancingV2::TargetGroup") | select(.LogicalResourceId | contains("CrawlerTargetGroupPublic")) | .PhysicalResourceId')
# envsubst < docker-compose.crawler.template.yml >docker-compose.crawler.yml
# envsubst < ecs-params.template.yml >ecs-params.crawler.yml

# ecs-cli compose --project-name ${SERVICE_NAME} --file docker-compose.crawler.yml \
#     --ecs-params ecs-params.crawler.yml --task-role-arn ${S3_SYNC_ROLE_ARN} service up \
#     --create-log-groups \
#     --target-group-arn $target_group_arn \
#     --private-dns-namespace service \
#     --enable-service-discovery \
#     --container-name ${SERVICE_NAME} \
#     --container-port 3000 \
#     --cluster-config ${ECS_CLUSTER_CONFIG} \
#     --vpc $vpc

# echo "Step 5: View running container, and store the output of the task id as an env variable for later use ..."
# ecs-cli compose --project-name fargate_twitter_reader --file docker-compose.crawler.yml service ps
# export fargate_twitter_reader_task_id=$(ecs-cli compose --project-name fargate_twitter_reader --file docker-compose.crawler.yml service ps | awk -F \/ 'FNR == 2 {print $1}')

# echo "Step 6: Check reachability ..."
# LB_URL=$(aws cloudformation describe-stacks --stack-name ecs-fargate-alb --query 'Stacks[0].Outputs[?OutputKey==`ExternalUrl`].OutputValue' --output text)
# echo "fargate-twitter-reader Crawler at: ${LB_URL}:3000/crawl/version"

# echo "Step 7: View logs ..."
# echo "View logs of crawler: ecs-cli logs --follow --task-id $fargate_twitter_reader_task_id"

ended_time=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "#########################################################"
echo "Deployment >> finished at ${ended_time}"
echo "#########################################################"
echo