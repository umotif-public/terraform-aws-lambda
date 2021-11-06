# Minimal example

Configuration in this example should allow you to quickly deploy a Lambda Function with minimal configurations.

The lambda function is inside the folder `image`. You will need to build the Dockerfile and push it to an ECR repository to be able to have a successful Terraform deployment.

## Create ECR & Lambda Image

Note: Feel free to change the repository names.

1. `aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws`
2. `aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin https://{ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com`
3. `aws ecr create-repository --repository-name "lambda/example-python"`
4. `cd image`
5. `docker build -t example-python .`
6. `docker tag example-python:latest {ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/lambda/example-python`
7. `docker push {ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/lambda/example-python`

## Deploy Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```
