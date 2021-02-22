# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

# Profile to use
export AWS_PROFILE=RKSPRO-DEV

# Delete service stack
aws cloudformation delete-stack \
  --stack-name springboot-aws-sample-1-service

# Wait for service stack deletion
aws cloudformation wait stack-delete-complete \
  --stack-name springboot-aws-sample-1-service

# Delete network stack
aws cloudformation delete-stack \
  --stack-name springboot-aws-sample-1-network

# Wait for network stack deletion
aws cloudformation wait stack-delete-complete \
  --stack-name springboot-aws-sample-1-network