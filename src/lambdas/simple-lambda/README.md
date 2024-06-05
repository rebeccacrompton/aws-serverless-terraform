# Simple AWS Lambda Function: List S3 Buckets
This repository contains a simple AWS Lambda function that demonstrates the deployment process using Terraform. The function interacts with AWS services, specifically Amazon S3, to showcase the need for IAM roles and policies.

## Overview
The lambda function is designed to be lightweight and doesn't require any external libraries beyond what is available in the Lambda environment by default. This allows us to package the lambda function into a zip file and deploy it using Terraform.

**Permissions**
The Lambda function requires specific permissions to perform its tasks. These permissions are managed through IAM (Identity and Access Management) roles and policies.

**IAM Policies**
- `lambda_s3_readonly_policy`: Grants the Lambda function the necessary permissions to read from S3 buckets by allowing the `s3:ListBucket` action.
- `AWSLambdaBasicExecutionRole`: Provides the Lambda function with permissions to write logs to CloudWatch Logs.

**IAM Role**
- `lambda_s3_readonly_role`: This IAM role is assumed by the Lambda function when it is executed. It is configured with the permissions specified in the associated policies.

## Usage

**Input Event**

The input event can be anything as it's not used by the Lambda function. It serves as a placeholder for potential future enhancements or integrations.

For example:
```json
{ }
```

**Response**
On successful execution, the Lambda function returns a JSON response containing the status code and a list of S3 bucket names.

Example response:
```json
{
  "statusCode": 200,
  "body": ["bucket1", "bucket2", "bucket3"]
}
```

**Error Response**
In case of errors or exceptions, the Lambda function returns an error response with the appropriate status code and error message.

Example error response:
```json
{
  "statusCode": 500,
  "body": {
    "error": "An error occurred while listing S3 buckets."
  }
}
```