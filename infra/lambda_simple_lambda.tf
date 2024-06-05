###################################
### Lambda function permissions ###
###################################

resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_readonly_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

data "aws_iam_policy_document" "lambda_s3_readonly_policy_document" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_readonly_policy"
  description = "Allows Lambda function to read from S3"
  policy      = data.aws_iam_policy_document.lambda_s3_readonly_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Attaches default AWSLambdaBasicExecutionRole policy (provides necessary permissions for CloudWatch Logs)
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#######################
### Lambda function ###
#######################

# Terraform data block to create a zip archive of the Lambda function code
data "archive_file" "lambda_zip" {
  excludes    = ["**/*.md"]
  type        = "zip"
  source_dir  = "${path.module}/../src/lambdas/simple-lambda"
  output_path = "${path.module}/../src/lambdas/simple-lambda/simple_lambda.zip"
}

resource "aws_lambda_function" "simple_lambda" {
  function_name = "simple-lambda"
  handler       = "main.handler"
  runtime       = "python3.9"
  timeout       = 10
  memory_size   = 128
  role          = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  publish = true # Publishes a new version of the Lambda function

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

###############
### Outputs ###
###############

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = aws_lambda_function.simple_lambda.arn
}
