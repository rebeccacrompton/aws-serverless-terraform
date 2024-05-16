# aws-serverless-terraform (work in progress)

This project demonstrates using Terraform to deploy AWS resources and GitHub Actions to automate the deployment process. Code pushed to a pull request will have Terraform resources planned to provide visibility on the impact of the code changes. Code merged to the main branch will have resources deployed to the AWS account.

## Project Structure
- infra: Contains all Terraform code for defining AWS infrastructure.
- .github: Contains GitHub Actions workflows for deploying Terraform resources.
- src: Contains source code for Lambda functions and state machines.

## GitHub Secrets
The repository is configured with the following GitHub secrets for securely accessing AWS:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`

## Included Resources
The project will deploy the following serverless resources on AWS:

- S3 Buckets: Configured with ACLs disabled, versioning enabled, and EventBridge notifications enabled.
- Python Lambda Functions: Serverless functions written in Python.
  - Docker deployment
  - Zip deployment
- State Machine: AWS Step Functions used to orchestrate workflows.
- Event Bridge Rule: Triggering state machine execution when a new file lands in an S3 bucket.