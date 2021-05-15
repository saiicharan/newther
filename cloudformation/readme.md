## Commands

To create a stack 

```
aws cloudformation create-stack --stack-name cfn-ecs-stack --template-body file://./ecs.yml --capabilities CAPABILITY_NAMED_IAM --parameters 'ParameterKey=SubnetID,ParameterValue=<subnet_id>'
```

To update the stack

```
aws cloudformation update-stack --stack-name cfn-ecs-stack --template-body file://./ecs.yml --capabilities CAPABILITY_NAMED_IAM --parameters 'ParameterKey=SubnetID,ParameterValue=<subnet_id>'
```
