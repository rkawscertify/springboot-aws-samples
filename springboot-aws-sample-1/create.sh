# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

# Profile to use
export AWS_PROFILE=RKSPRO-DEV

# create network from defnition in network.yml
aws cloudformation create-stack \
  --stack-name springboot-aws-sample-1-network \
  --template-body file://network.yml \
  --capabilities CAPABILITY_IAM

# wait for network creation
aws cloudformation wait stack-create-complete \
  --stack-name springboot-aws-sample-1-network

# create service from definition in service.yml
aws cloudformation create-stack \
  --stack-name springboot-aws-sample-1-service \
  --template-body file://service.yml \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=springboot-aws-sample-1-network \
      ParameterKey=ServiceName,ParameterValue=springboot-aws-sample-1-service \
      ParameterKey=ImageUrl,ParameterValue=docker.io/rkawscertify/springboot-aws-sample-1:latest \
      ParameterKey=ContainerPort,ParameterValue=8080

# wait for service creation
aws cloudformation wait stack-create-complete --stack-name springboot-aws-sample-1-service

# various value echos
CLUSTER_NAME=$(aws cloudformation describe-stacks --stack-name springboot-aws-sample-1-network --output text --query 'Stacks[0].Outputs[?OutputKey==`ClusterName`].OutputValue | [0]')
echo "ECS Cluster:       " $CLUSTER_NAME

TASK_ARN=$(aws ecs list-tasks --cluster $CLUSTER_NAME --output text --query 'taskArns[0]')
echo "ECS Task:          " $TASK_ARN

ENI_ID=$(aws ecs describe-tasks --cluster $CLUSTER_NAME --tasks $TASK_ARN --output text --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value')
echo "Network Interface: " $ENI_ID

PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --output text --query 'NetworkInterfaces[0].Association.PublicIp')
echo "Public IP:         " $PUBLIC_IP

echo "You can access your service at http://$PUBLIC_IP:8080"